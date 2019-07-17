//
//  CartCartInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol CartInteractorInput {
    func fetchPaymentItems()
    func removePaymentItem(_ paymentItem: PaymentItem)
    func retrievePoint()
    func trackView()
    func trackCartEvent()
}
