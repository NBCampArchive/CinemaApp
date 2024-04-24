//
//  registerViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/23/24.
//

import UIKit

class BaseRegisterViewController: UIViewController {

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
    
    // MARK: - Alert: 정보 다 안 채우고 가입하기 버튼 누를 경우
    func showAlertIfDataIncomplete(userName: String?, userID: String?, userPW: String?) {
        // Alert Title 설정
        var alertTitle = ""
        if userName == nil || userName == "" {
            alertTitle = "이름을 입력하세요."
        } else if userID == nil || userID == "" {
            alertTitle = "아이디를 입력하세요"
        } else if userPW == nil || userPW == "" {
            alertTitle = "비밀번호를 입력하세요"
        }
        // Alert 확인 action 설정
        let ok = UIAlertAction(title: "확인", style: .cancel)

        // Alert Controller 세팅, 띄우기
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Alert: 정상 가입 되었을 경우
    func showAlertIfDataComplete() {
        let alert = UIAlertController(title: "회원가입 완료", message: "회원가입이 완료되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
}
