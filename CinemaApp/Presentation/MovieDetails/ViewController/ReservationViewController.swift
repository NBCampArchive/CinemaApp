//
//  ReservationViewController.swift
//  CinemaApp
//
//  Created by 강태영 on 4/25/24.
//

import UIKit

class ReservationViewContrroller: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var payButton: UIButton! // payButton IBOutlet 추가
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // stepper의 최솟값, 최댓값, 초기값 설정
        numberStepper.minimumValue = 0
        numberStepper.maximumValue = 100
        numberStepper.value = 0
        
        // 초기 라벨 값 설정
        numberLabel.text = "0"
        
        // stepper의 Value Changed 이벤트에 대한 액션 추가
        numberStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        // stepper의 값이 변경될 때마다 라벨에 반영
        numberLabel.text = "\(Int(sender.value))"
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
            // 결제 여부를 묻는 알림창 표시
            let paymentAlert = UIAlertController(title: "결제하기", message: "결제하시겠습니까?", preferredStyle: .alert)
            
            // 확인 액션 추가
            paymentAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                // 결제 완료 알림창 표시
                let successAlert = UIAlertController(title: "결제 완료", message: "결제되었습니다.", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                    // 결제가 완료되면 numberLabel의 값을 다시 0으로 설정
                    self.numberLabel.text = "0"
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
