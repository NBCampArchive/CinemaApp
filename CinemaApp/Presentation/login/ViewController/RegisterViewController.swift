//
//  registerViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/23/24.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupUI()
    }
    
    // MARK: - UI Setting functions
    func setupUI() {
    }
    
    func setupConstraints() {
    }
    
    // MARK: - 정보 다 안 채우고 가입하기 버튼 누를 경우 Alert
    func showAlertIfDataIncomplete(userName: String?, userID: String?, userPW: String?) {
        print("Alert 함수 실행!")
        // Alert Title 설정
        var alertTitle = ""
        if userName == nil {
            alertTitle = "이름을 입력하세요."
        } else if userID == nil {
            alertTitle = "아이디를 입력하세요"
        } else if userPW == nil {
            alertTitle = "비밀번호를 입력하세요"
        }
        
        // Alert 확인 action 설정
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        // Alert Controller 세팅
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        alert.addAction(ok)
        
        // Alert Controller 띄우기
        self.present(alert, animated: true, completion: nil)
    }
}
