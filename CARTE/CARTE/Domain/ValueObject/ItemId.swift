//
//  ItemId.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

struct ItemId: Equatable {
    let id: String
    
    static func ==(lhs: ItemId, rhs: ItemId) -> Bool {
        return lhs.id == rhs.id
    }
}
