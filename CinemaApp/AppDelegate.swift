//
//  AppDelegate.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/22/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Navigation Bar의 타이틀 색상 변경
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "labelTextColor") ?? .white]
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor:  UIColor(named: "labelTextColor") ?? .white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        // Back 버튼 색상 변경
        let backButtonAppearance = UIBarButtonItem.appearance()
        backButtonAppearance.tintColor = UIColor(named: "labelTextColor") ?? .white
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

