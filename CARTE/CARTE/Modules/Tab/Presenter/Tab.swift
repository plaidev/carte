//
//  Tab.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/10.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

enum Tab {
    case home(_ content: HomeContent?)
    case favorite
    case search
    case information
    case mypage
    
    var index: Int {
        switch self {
        case .home:
            return 0
        case .favorite:
            return 1
        case .search:
            return 2
        case .information:
            return 3
        case .mypage:
            return 4
        }
    }
}
