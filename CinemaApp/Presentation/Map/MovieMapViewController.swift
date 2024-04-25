//
//  MovieMapViewController.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/25/24.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class MovieMapViewController: UIViewController, MKMapViewDelegate, FloatingPanelControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var fpc: FloatingPanelController!
    var floatingPanelController: FloatingPanelController?
    var contentVC: UIViewController!
    var annotation: MKPointAnnotation!
    var theaterName: String = ""
    var theaterURL: String = ""
    var theaterAddress: String = ""
    var theaterPhone: String = ""
    
    let locationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "location.fill"), for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-100)
        }
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        mapView.delegate = self
        
        // 지도 설정
        mapView.preferredConfiguration = MKStandardMapConfiguration()
        
        // 줌 가능 여부
        mapView.isZoomEnabled = true
        // 이동 가능 여부
        mapView.isScrollEnabled = true
        // 각도 조절 가능 여부 (두 손가락으로 위/아래 슬라이드)
        mapView.isPitchEnabled = true
        // 회전 가능 여부
        mapView.isRotateEnabled = true
        // 나침판 표시 여부
        mapView.showsCompass = true
        // 축척 정보 표시 여부
        mapView.showsScale = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func locationButtonTapped() {
        locationManager.startUpdatingLocation()
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func searchNearbyTheaters(location: CLLocation) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Movie Theater"
        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // 검색 결과를 지도에 추가
            for item in response.mapItems {
                let annotation = CustomAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.url = item.url?.absoluteString
                annotation.address = item.placemark.title
                annotation.phone = item.phoneNumber
                self.mapView.addAnnotation(annotation)
            }
            
            // 사용자 위치를 기준으로 지도 영역 설정
            let userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 3000, longitudinalMeters: 3000)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? CustomAnnotation else {
            return
        }
        self.annotation = annotation
        // 선택한 핀포인트의 정보 가져오기
        self.theaterName = annotation.title ?? "Unknown Theater"
        self.theaterURL = annotation.url ?? "Phone Not Available"
        self.theaterAddress = annotation.address ?? "Unknown Place"
        self.theaterPhone = annotation.phone ?? "Phone Not Available"
        let theaterDescription = annotation.coordinate
        // 영화관 정보 출력
        print("Theater Name: \(theaterName)")
        print("Theater URL: \(theaterURL)")
        print("Theater Address: \(theaterAddress)")
        print("Theater PhoneNumber: \(theaterPhone)")
        
        showFloatingPanel()
    }
    
    func showRouteToAnnotation(_ annotation: MKPointAnnotation, transportType: MKDirectionsTransportType) {
        guard let userLocation = mapView.userLocation.location else {
            return
        }
        
        // 이전에 그려진 경로 제거
        mapView.removeOverlays(mapView.overlays)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
        request.transportType = transportType
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error calculating route: \(error.localizedDescription)")
                return
            }
            
            guard let route = response?.routes.first else {
                print("No route found")
                return
            }
            
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor(named: "customPrimaryColor")
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension MovieMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("위치 권한 허용됨")
            manager.startUpdatingLocation() // 위치 업데이트 시작
            locationManager.requestLocation() // 사용자의 위치 요청
            mapView.showsUserLocation = true
        case .denied, .restricted:
            print("""
                위치 권한이 거부되었거나 제한되었습니다.
                설정 앱에서 위치 권한을 허용해주세요.
                """)
            mapView.showsUserLocation = false
            // 위치 권한이 거부되었을 때 처리할 내용 추가
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // 사용자의 현재 위치로 지도 이동
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        mapView.setRegion(region, animated: true)
        
        // 주변 영화관 검색
        searchNearbyTheaters(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

class CustomAnnotation: MKPointAnnotation {
    var url: String?
    var address: String?
    var phone: String?
}
