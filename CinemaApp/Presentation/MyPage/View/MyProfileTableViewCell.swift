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
    
    var editUserInfoButton: (() -> ()) = {}
    
    @IBAction func tappedEditUserInfoButton(_ sender: UIButton) {
        editUserInfoButton()
    }
    
    func fetchUserData() {
        userName = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
        userID = UserDefaults.standard.value(forKey: "userID") as? String ?? ""
    }
    
    func configure() {
        fetchUserData()
        userNameLabel.text = "\(self.userName)님"
        userIDLabel.text = "ID: \(self.userID)"
    }
    
    
}
