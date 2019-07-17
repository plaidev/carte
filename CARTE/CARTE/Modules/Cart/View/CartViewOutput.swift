//
//  CartCartViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol CartViewOutput {
    var numberOfPaymentItems: Int { get }
    var price: Price { get }
    var freeShippingBalance: Price { get }
    
    func viewIsReady()
    func viewDidAppear()
    func paymentItemAt(_ index: Int) -> PaymentItem
    func removePaymentItem(_ paymentItem: PaymentItem)
    func tapRegistrationButton()
    func tapContinueShoppingButton()
}
