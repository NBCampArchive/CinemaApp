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
        let userName = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
        let userID = UserDefaults.standard.value(forKey: "userID") as? String ?? ""
        userNameLabel.text = "\(userName)님"
        userIDLabel.text = "ID: \(userID)"
    }
    
    
}
