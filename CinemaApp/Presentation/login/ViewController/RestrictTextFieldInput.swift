//
//  RestrictTextFieldInput.swift
//  CinemaApp
//
//  Created by 유림 on 4/26/24.
//

import Foundation
import SwiftUI
//
//class RestrictTextFieldInput {
//    
//    enum checkResult {
//        case allow
//        case reject
//    }
//    
//    var currentCheckResult: checkResult?
//    
//    func englishNumberCheck(_ input: String) -> Bool {
//        let pattern = "^[a-zA-Z\\s]*$"
//        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
//            let range = NSRange(location: 0, length: input.utf16.count)
//            if regex.firstMatch(in: input, range: range) != nil {
//                return true
//            }
//        }
//        return false
//    }
//    
//    func judgeInput(_ textField: TextField) {
//        textField.onChange { newValue in
//            if self.englishNumberCheck(newValue) {
//                self.currentCheckResult = .allow
//            } else {
//                self.currentCheckResult = .reject
//            }
//            
//        }
//    }
//
//}
