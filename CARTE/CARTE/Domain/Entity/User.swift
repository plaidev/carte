//
//  User.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/13.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

struct User {
    var id: UserId
    var anonymous: Bool
    var subscription: Bool
    var shopNotification: Bool
    var brandNotification: Bool
    var birthDate: Date?
    var point: Int
}
