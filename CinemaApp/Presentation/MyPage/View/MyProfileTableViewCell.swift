//
//  MyProfileTableViewCell.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    static let identifier = "myProfileCell"
    
    func configure() {
        userNameLabel.text = "유저이름"
        userIDLabel.text = "User ID"
//        userNameLabel.text = UserDefaults.standard.value(forKey: "userName") as? String
//        userIDLabel.text = UserDefaults.standard.value(forKey: "userID") as? String
    }
    
    
}
