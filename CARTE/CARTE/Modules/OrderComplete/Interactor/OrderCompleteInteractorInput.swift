//
//  OrderCompleteOrderCompleteInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol OrderCompleteInteractorInput {
    func removeCartItems(paymentItems: [PaymentItem])
    func givePoints(paymentItems: [PaymentItem])
}
