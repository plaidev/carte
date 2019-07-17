//
//  OrderCompleteOrderCompleteViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol OrderCompleteViewOutput {
    var orderItemsJson: String { get }
    func viewIsReady()
    func tapContinueShoppingButton()
}
