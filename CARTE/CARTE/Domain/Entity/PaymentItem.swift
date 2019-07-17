//
//  Payment.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/07.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

class PaymentItem {
    let item: Item
    var quantity: UInt
    var price: Price {
        return Price(value: item.price.value * Int(quantity))
    }
    
    init(item: Item) {
        self.item = item
        self.quantity = 1
    }
    
    func increment() {
        quantity += 1
    }
}
