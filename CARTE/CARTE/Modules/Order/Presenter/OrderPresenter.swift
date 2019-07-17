//
//  OrderOrderPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

class OrderPresenter: OrderModuleInput, OrderInteractorOutput {

    weak var view: OrderViewInput!
    var interactor: OrderInteractorInput!
    var router: OrderRouterInput!

    private let paymentItems: [PaymentItem]
    
    init(paymentItems: [PaymentItem]) {
        self.paymentItems = paymentItems
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

extension OrderPresenter: OrderViewOutput {
    
    func tapOrderCompleteButton() {
        router.showOrderComplete(paymentItems: paymentItems)
    }
    
    func tapContinueShoppingButton() {
        router.close()
    }
}
