//
//  CartCartPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift

class CartPresenter {

    weak var view: CartViewInput!
    var interactor: CartInteractorInput!
    var router: CartRouterInput!

    private var paymentItems = [PaymentItem]()
    
    func viewIsReady() {
        interactor.fetchPaymentItems()
        interactor.retrievePoint()
        view.setupInitialState()
    }
    
    func viewDidAppear() {
        interactor.trackView()
    }
}

extension CartPresenter: CartViewOutput {
    
    var numberOfPaymentItems: Int {
        return paymentItems.count
    }
    
    var price: Price {
        if paymentItems.isEmpty {
            return Price(value: 0)
        } else {
            return paymentItems.reduce(Price(value: 0), { (price, payment) -> Price in
                return price + payment.price
            })
        }
    }
    
    var freeShippingBalance: Price {
        if Price(value: 30000) <= price {
            return Price(value: 0)
        } else {
            return Price(value: 30000) - price
        }
    }
    
    func paymentItemAt(_ index: Int) -> PaymentItem {
        return paymentItems[index]
    }
    
    func removePaymentItem(_ paymentItem: PaymentItem) {
        interactor.removePaymentItem(paymentItem)
    }
    
    func tapRegistrationButton() {
        router.showOrder(paymentItems: paymentItems)
    }
    
    func tapContinueShoppingButton() {
        router.close()
    }
}

extension CartPresenter: CartInteractorOutput {
    
    func fetchedPaymentItems(_ event: SingleEvent<[PaymentItem]>) {
        switch event {
        case .success(let payments):
            self.paymentItems = payments
            self.view.setupInitialState()
        case .error(_):
            break
        }
    }
    
    func removedPaymentItem(_ event: SingleEvent<Void>) {
        switch event {
        case .success(_):
            interactor.trackCartEvent()
            break
        case .error(_):
            break
        }
    }
    
    func retrievedPoint(_ point: Int) {
        view.refreshPoint(point)
    }
}
