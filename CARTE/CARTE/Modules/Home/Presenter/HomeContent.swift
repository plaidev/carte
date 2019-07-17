//
//  HomeContent.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/12.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

enum HomeContent {
    case cart
    case item(_ itemId: ItemId)
    case search(_ q: String)
}
