//
//  Price.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

struct Price: Equatable, Comparable {
    let value: Int
    let currency: Currency
    
    init(value: Int) {
        self.value = value
        self.currency = .jpy
    }
    
    var string: String {
        return currency.stringFromValue(value)
    }
    
    static func +(lhs: Price, rhs: Price) -> Price {
        return Price(value:  lhs.value + rhs.value)
    }
    
    static func -(lhs: Price, rhs: Price) -> Price {
        return Price(value: lhs.value - rhs.value)
    }
    
    static func ==(lhs: Price, rhs: Price) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func <(lhs: Price, rhs: Price) -> Bool {
        return lhs.value < rhs.value
    }
}

enum Currency: String {
    case jpy = "JPY"
    
    func stringFromValue(_ value: Int) -> String {
        switch self {
        case .jpy:
            return "¥\(value.ext.comma)"
        }
    }
}
