//
//  MyProfileTableViewCell.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import UIKit

protocol EditUserInfoDelegate: AnyObject {
    func goToRegisterView()
}

class MyProfileTableViewCell: UITableViewCell {
    static let identifier = "myProfileCell"
    var userName = ""
    var userID = ""
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    
    
    // 회원정보 수정 버튼 탭
    @IBAction func tappedEditUserInfoButton(_ sender: UIButton) {
        editUserInfoButton()
    }
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        logoutButton()
    }
    
    
    // MARK: - 기능 구현 함수
    
    // 1. 회원정보 수정 클로저
    var editUserInfoButton: (() -> ()) = {}
    
    // 2. 로그아웃 클로저
    var logoutButton: (() -> ()) = {}
    
    // 3. userDefaults에 저장된 데이터 불러오는 함수
    func fetchUserData() {
        userName = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
        userID = UserDefaults.standard.value(forKey: "userID") as? String ?? ""
    }
    
    // 4. cell 컴포넌트 레이블 설정하는 함수
    func configure() {
        fetchUserData()
        userNameLabel.text = "\(self.userName)님"
        userIDLabel.text = "ID: \(self.userID)"
    }
    
    
}
