//
//  OrderCompleteOrderCompletePresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

class OrderCompletePresenter {

    weak var view: OrderCompleteViewInput!
    var interactor: OrderCompleteInteractorInput!
    var router: OrderCompleteRouterInput!

    private let paymentItems: [PaymentItem]
    
    init(paymentItems: [PaymentItem]) {
        self.paymentItems = paymentItems
    }
    
    func viewIsReady() {
        interactor.removeCartItems(paymentItems: paymentItems)
        interactor.givePoints(paymentItems: paymentItems)
        view.setupInitialState()
    }
    
    struct OrderItem: Codable {
        var id: String
        var brand: String
        var name: String
        var quantity: UInt
        var price: String
        var priceValue: Int
        var image: String
        var category: String
        
        init(paymentItem: PaymentItem) {
            self.id = paymentItem.item.id.id
            self.brand = paymentItem.item.brand
            self.name = paymentItem.item.name
            self.quantity = paymentItem.quantity
            self.price = paymentItem.item.price.string
            self.priceValue = paymentItem.item.price.value
            self.image = paymentItem.item.image.middle?.source ?? ""
            self.category = paymentItem.item.category ?? ""
        }
    }
}

extension OrderCompletePresenter: OrderCompleteViewOutput {
    
    var orderItemsJson: String {
        let orderItems = paymentItems.map { OrderItem(paymentItem: $0) }
        
        let encoder = JSONEncoder()
        let string = (try? encoder.encode(orderItems)).flatMap { String(data: $0, encoding: .utf8) } ?? "[]"
        return string
    }
    
    func tapContinueShoppingButton() {
        router.close()
    }
}

extension OrderCompletePresenter: OrderCompleteInteractorOutput {
    
    func removedCartItems(_ event: SingleEvent<Void>) {
    }
}
