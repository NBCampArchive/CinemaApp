//
//  ReservationViewController.swift
//  CinemaApp
//
//  Created by 강태영 on 4/25/24.
//

import UIKit

class ReservationViewContrroller: UIViewController {
    
    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var groundView: UIView!
    @IBOutlet weak var movietitleLabel: UILabel!
    @IBOutlet weak var totalpriceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var humannumberLabel: UILabel!
    
    var posterPath: String?
    var movieTitle: String?
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        groundView.backgroundColor = UIColor(named:"BackgroundColor")
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor(named: "LabelTextColor")
        numberLabel.backgroundColor = UIColor.clear
        numberLabel.textColor = UIColor(named: "LabelTextColor")
        priceLabel.backgroundColor = UIColor.clear
        priceLabel.textColor = UIColor(named: "LabelTextColor")
        movietitleLabel.backgroundColor = UIColor.clear
        priceLabel.textColor = UIColor(named: "LabelTextColor")
        totalpriceLabel.backgroundColor = UIColor.clear
        totalpriceLabel.textColor = UIColor(named: "LabelTextColor")
        dateLabel.backgroundColor = UIColor.clear
        dateLabel.textColor = UIColor(named: "LabelTextColor")
        humannumberLabel.backgroundColor = UIColor.clear
        humannumberLabel.textColor = UIColor(named: "LabelTextColor")
        
        // stepper의 최솟값, 최댓값, 초기값 설정
        numberStepper.minimumValue = 0
        numberStepper.maximumValue = 100
        numberStepper.value = 0
        
        // 초기 라벨 값 설정
        titleLabel.text = movieTitle
        numberLabel.text = "0"
        
        // stepper의 Value Changed 이벤트에 대한 액션 추가
        numberStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        // 코너 반경 설정
        payButton.layer.cornerRadius = 10 // 적절한 값을 넣어주세요
        
        // 추가적인 스타일링
        payButton.backgroundColor = UIColor.blue
        payButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        // stepper의 값이 변경될 때마다 라벨에 반영
        numberLabel.text = "\(Int(sender.value))"
        // numberLabel의 텍스트를 숫자로 변환
        if let number = Int(numberLabel.text ?? "0") {
            let result = number * 10000
            priceLabel.text = "\(result)원"
        } else {
            priceLabel.text = "계산 불가"
        }
    }
    
    func saveReservation(_ reservation: Reservation) {
        var reservations = loadReservations()
        reservations.append(reservation)
        
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(reservations) {
            UserDefaults.standard.set(encodedData, forKey: "reservations")
        }
    }
    
    func loadReservations() -> [Reservation] {
        if let data = UserDefaults.standard.data(forKey: "reservations") {
            let decoder = JSONDecoder()
            if let reservations = try? decoder.decode([Reservation].self, from: data) {
                return reservations
            }
        }
        return []
    }
    
    @IBAction func payButtonTapped(_ sender: Any) {
        // numberLabel의 값을 가져옴
        guard let numberOfPeople = Int(numberLabel.text ?? "0") else {
            // 숫자로 변환할 수 없는 경우 기본값으로 0을 설정
            return
        }
        
        // 인원 수가 0명인 경우
        if numberOfPeople == 0 {
            // 알림창 표시
            let alert = UIAlertController(title: "알림", message: "인원 수를 선택해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        } else {
            // 예매 정보 저장
            if let movieId = self.movieId,
               let movieTitle = self.movieTitle,
               let people = Int(self.numberLabel.text ?? "0"),
               let price = Int(self.priceLabel.text?.replacingOccurrences(of: "원", with: "") ?? "0"){
                let date = self.datePicker.date
                
                // 예매 시간 중복 확인
                let reservations = self.loadReservations()
                let hasResrvation = reservations.contains{ reservation in
                    let timeInterval = reservation.date.timeIntervalSince(date)
                    return timeInterval < 3600 && timeInterval > -3600
                }
                
                // 예매 시간 중복 시 알림창 표시
                if hasResrvation {
                    let alert = UIAlertController(title: "알림", message: "이미 예매된 시간입니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true)
                } else {
                    // 결제 여부를 묻는 알림창 표시
                    let paymentAlert = UIAlertController(title: "결제하기", message: "결제하시겠습니까?", preferredStyle: .alert)
                    
                    // 확인 액션 추가
                    paymentAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                        // 결제 완료 알림창 표시
                        let successAlert = UIAlertController(title: "결제 완료", message: "결제되었습니다.", preferredStyle: .alert)
                        successAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                            let reservation = Reservation(movieId: movieId, movieTitle: movieTitle, posterPath: self.posterPath, people: people, price: price, date: date)
                            self.saveReservation(reservation)
                            
                            self.dismiss(animated: true)
                        }))
                        self.present(successAlert, animated: true, completion: nil)
                    }))
                    // 취소 액션 추가
                    paymentAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in
                        // 결제 취소 알림창 표시
                        let cancelAlert = UIAlertController(title: "결제 취소", message: "취소되었습니다.", preferredStyle: .alert)
                        cancelAlert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.present(cancelAlert, animated: true, completion: nil)
                    }))
                    
                    // 결제 알림창 표시
                    present(paymentAlert, animated: true, completion: nil)
                    
                }
            }
           
            
            
        }
    }
}
