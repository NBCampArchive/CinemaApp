//
//  MyProfileTableViewCell.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {
    static let identifier = "myProfileCell"
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBAction func tappedEditUserInfoButton(_ sender: UIButton) {
        
    }
    
    
    func configure() {
        let userName = UserDefaults.standard.value(forKey: "userName") as? String ?? ""
        let userID = UserDefaults.standard.value(forKey: "userID") as? String ?? ""
        userNameLabel.text = "\(userName)님"
        userIDLabel.text = "ID: \(userID)"
    }
    
    
}
