//
//  MyPageCellType.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import Foundation


enum ViewModelItemType {
    case myProfile
    case myMenu
}

protocol ViewModelItem {
    var type: ViewModelItemType { get }
    var rowCount: Int { get }
}


// MARK: - 메뉴 타입별 변수 설정
class ProfileItem: ViewModelItem {
    var type: ViewModelItemType { return .myProfile }
    var rowCount: Int = 1
}

class MyMenuItem: ViewModelItem {
    var type: ViewModelItemType { return .myMenu }
    
    var rowCount: Int = 1
    
    var menuTitle: String
    
    init(menuTitle: String) {
        self.menuTitle = menuTitle
    }
    
    
}
