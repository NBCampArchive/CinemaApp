//
//  EasyAlertFunc.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import Foundation
import UIKit

class EasyAlert {
    class func showAlert(title: String?, message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
    
    class func dismissModalAlert(title: String?, message: String?, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel) { [weak vc] _ in
            vc?.dismiss(animated: true)
        }
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
}
