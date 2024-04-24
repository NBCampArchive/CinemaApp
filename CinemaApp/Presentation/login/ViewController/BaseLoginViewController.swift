//
//  LoginViewController.swift
//  CinemaApp
//
//  Created by 유림 on 4/22/24.
//

import UIKit
import SnapKit

class BaseLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        let upcomingApiManager = UpcomingMovieApiManager()
        upcomingApiManager.fetchUpcomingMovie()
    }
    

    
    
    // MARK: - UI Setting functions
    func setupUI() {
    }
    
    func setupConstraints() {
    }
}
