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
    let userName = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
    let userID = UserDefaults.standard.value(forKey: "userID") as? String ?? ""
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    //var editUserInfoButton: (() -> ()) = {}
    
    @IBAction func tappedEditUserInfoButton(_ sender: UIButton) {
        //editUserInfoButton()
    }
    
    
    func configure() {
        
        userNameLabel.text = "\(userName)님"
        userIDLabel.text = "ID: \(userID)"
    }
    
    
}
