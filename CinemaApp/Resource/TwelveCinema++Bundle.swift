//
//  TwelveCinema++Bundle.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/23/24.
//

import Foundation

extension Bundle{
    
    var apiKey: String {
        guard let file = self.path(forResource: "TwelveCinemaInfo", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let apiKey = resource["API_KEY"] as? String else { fatalError("TwelveCinemaInfo에 API_KEY를 등록해주세요.") }
        
        return apiKey
    }
    
    var token: String {
        guard let file = self.path(forResource: "TwelveCinemaInfo", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let token = resource["API_TOKEN"] as? String else { fatalError("TwelveCinemaInfo에 TOKEN을 등록해주세요.") }
        
        return token
    }
    
}
