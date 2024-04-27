//
//  MovieMapFloatingPanel.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/26/24.
//

import UIKit
import SnapKit
import FloatingPanel
import MapKit
import Then

// MARK: - FloaingPanel
extension MovieMapViewController{
    
    func showFloatingPanel() {
        // FloatingPanel 설정 및 표시
        contentVC = UIViewController()
        contentVC.view.backgroundColor = .white
        
        let titleLabel = UILabel().then{
            $0.text = theaterName
            $0.font = .boldSystemFont(ofSize: 24)
        }
        
        let stackView = UIStackView().then{
            $0.axis = .horizontal
            $0.spacing = 10
            $0.alignment = .leading
            $0.distribution = .fillEqually
        }
        
        let walkRouteButton = UIButton().then {
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Walk"
            configuration.image = UIImage(systemName: "figure.walk", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white]))
            configuration.imagePadding = 10
            configuration.imagePlacement = .top
            configuration.baseBackgroundColor = UIColor(red: 0.07, green: 0.18, blue: 0.31, alpha: 1.00)
            configuration.baseForegroundColor = .white
            configuration.cornerStyle = .dynamic
            
            // titleTextAttributesTransformer를 사용하여 타이틀의 글꼴 설정
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .boldSystemFont(ofSize: 17)
                return outgoing
            }
            $0.tag = 0
            $0.configuration = configuration
        }
        walkRouteButton.addTarget(self, action: #selector(showRoute), for: .touchUpInside)
        
        let carRouteButton = UIButton().then {
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Car"
            configuration.image = UIImage(systemName: "car.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white]))
            configuration.imagePadding = 10
            configuration.imagePlacement = .top
            configuration.baseBackgroundColor = UIColor(red: 0.07, green: 0.18, blue: 0.31, alpha: 1.00)
            configuration.baseForegroundColor = .white
            configuration.cornerStyle = .dynamic
            
            // titleTextAttributesTransformer를 사용하여 타이틀의 글꼴 설정
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .boldSystemFont(ofSize: 17)
                return outgoing
            }
            $0.tag = 1
            $0.configuration = configuration
        }
        carRouteButton.addTarget(self, action: #selector(showRoute), for: .touchUpInside)
        
        let urlButton = UIButton().then {
            var configuration = UIButton.Configuration.filled()
            configuration.title = "URL"
            configuration.image = UIImage(systemName: "safari.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white]))
            configuration.imagePadding = 10
            configuration.imagePlacement = .top
            configuration.baseBackgroundColor = UIColor(red: 0.07, green: 0.18, blue: 0.31, alpha: 1.00)
            configuration.baseForegroundColor = .white
            configuration.cornerStyle = .dynamic
            
            // titleTextAttributesTransformer를 사용하여 타이틀의 글꼴 설정
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .boldSystemFont(ofSize: 17)
                return outgoing
            }
            
            $0.configuration = configuration
        }
        urlButton.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        
        let addressTitle = UILabel().then{
            $0.text = "Address"
            $0.font = .boldSystemFont(ofSize: 20)
        }
        let addressLabel = UILabel().then{
            $0.text = theaterAddress
            $0.font = .systemFont(ofSize: 17)
            $0.numberOfLines = 0
        }
        
        let phoneTitle = UILabel().then{
            $0.text = "Phone"
            $0.font = .boldSystemFont(ofSize: 20)
        }
        let phoneLabel = UILabel().then{
            $0.text = theaterPhone
            $0.font = .systemFont(ofSize: 17)
        }
        
        
        contentVC.view.addSubview(titleLabel)
        contentVC.view.addSubview(stackView)
        stackView.addArrangedSubview(walkRouteButton)
        stackView.addArrangedSubview(carRouteButton)
        stackView.addArrangedSubview(urlButton)
        contentVC.view.addSubview(addressTitle)
        contentVC.view.addSubview(addressLabel)
        contentVC.view.addSubview(phoneTitle)
        contentVC.view.addSubview(phoneLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentVC.view.snp.topMargin).offset(20)
            $0.leading.equalTo(contentVC.view.snp.leading).offset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        addressTitle.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.leading.equalTo(contentVC.view.snp.leading).offset(16)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(addressTitle.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        phoneTitle.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(16)
            $0.leading.equalTo(contentVC.view.snp.leading).offset(16)
        }
        phoneLabel.snp.makeConstraints {
            $0.top.equalTo(phoneTitle.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        fpc = FloatingPanelController()
        fpc.layout = CustomFloatingPanelLayout()
        fpc.delegate = self
        fpc.set(contentViewController: contentVC)
        fpc.isRemovalInteractionEnabled = true
       
        self.dismiss(animated: true, completion: nil)
        self.present(fpc, animated: true, completion: nil)
    }
    
    @objc func openURL() {
        if let url = URL(string: theaterURL) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func showRoute(_ sender: UIButton) {
        let transportType: MKDirectionsTransportType
        switch sender.tag {
        case 0:
            transportType = .walking
        case 1:
            transportType = .automobile
        default:
            transportType = .automobile
        }
        print(sender.tag)
        
        showRouteToAnnotation(annotation, transportType: transportType)
    }
    
}

class CustomFloatingPanelLayout: FloatingPanelLayout{
    var position: FloatingPanelPosition = .bottom
    var initialState: FloatingPanelState = .tip
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .superview),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 270.0, edge: .bottom, referenceGuide: .superview),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 110.0, edge: .bottom, referenceGuide: .superview)
        ]
    }
}
