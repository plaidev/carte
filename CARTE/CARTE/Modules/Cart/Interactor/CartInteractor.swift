//
//  CartCartInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import FirebaseAuth
import FirebaseAnalytics
import KarteTracker

class CartInteractor: CartInteractorInput {
    
    weak var output: CartInteractorOutput!

    private let cartRepository: CartRepository
    private let itemRepository: ItemRepository
    private let userRepository: UserRepository
    
    init(cartRepository: CartRepository, itemRepository: ItemRepository, userRepository: UserRepository) {
        self.cartRepository = cartRepository
        self.itemRepository = itemRepository
        self.userRepository = userRepository
    }
    
    func fetchPaymentItems() {
        let itemRepository = self.itemRepository
        _ = cartRepository.fetchAll().flatMap { (itemIds) -> PrimitiveSequence<SingleTrait, [Item]> in
            return itemRepository.fetchItems(itemIds: itemIds)
        }.map { (items) -> [PaymentItem] in
            return items.reduce([], { (paymentItems, item) -> [PaymentItem] in
                var paymentItems = paymentItems
                if let paymentItem = paymentItems.first(where: { $0.item.id == item.id }) {
                    paymentItem.increment()
                } else {
                    paymentItems.append(PaymentItem(item: item))
                }
                return paymentItems
            })
        }.subscribe { [weak self] (event) in
            self?.output.fetchedPaymentItems(event)
        }
    }
    
    func removePaymentItem(_ paymentItem: PaymentItem) {
        _ = cartRepository.remove(itemId: paymentItem.item.id).subscribe { [weak self] (event) in
            self?.output.removedPaymentItem(event)
            self?.fetchPaymentItems()
        }
    }
    
    func retrievePoint() {
        guard let fuser = Auth.auth().currentUser else {
            return
        }
        
        _ = userRepository.retrieveUser(userId: UserId(id: fuser.uid)).subscribe({ [weak self] (event) in
            guard case let .success(user) = event else {
                return
            }
            self?.output.retrievedPoint(user.point)
        })
    }
    
    func trackView() {
        KarteTracker.shared.view("cart", title: "カート", values: [
            "view_id": "cart"
        ])
    }
    
    func trackCartEvent() {
        let itemRepository = self.itemRepository
        _ = cartRepository.fetchAll().flatMap { (itemIds) -> PrimitiveSequence<SingleTrait, [Item]> in
            return itemRepository.fetchItems(itemIds: itemIds)
        }.map { (items) -> [PaymentItem] in
            return items.reduce([], { (paymentItems, item) -> [PaymentItem] in
                var paymentItems = paymentItems
                if let paymentItem = paymentItems.first(where: { $0.item.id == item.id }) {
                    paymentItem.increment()
                } else {
                    paymentItems.append(PaymentItem(item: item))
                }
                return paymentItems
            })
        }.subscribe { (event) in
            guard case let .success(paymentItems) = event else {
                return
            }
                
            let totalPrice = paymentItems.reduce(0, { (total, paymentItem) -> Int in
                return total + paymentItem.price.value
            })
            let quantity = paymentItems.reduce(0, { (total, paymentItem) -> UInt in
                return total + paymentItem.quantity
            })
            let items = paymentItems.map({ (paymentItem) -> [AnyHashable: Any] in
                return [
                    "item_name": paymentItem.item.name,
                    "item_id": paymentItem.item.id.id,
                    "brand_name": paymentItem.item.brand,
                    "price": paymentItem.item.price.value,
                    "item_image_url": paymentItem.item.image.middle?.source ?? "",
                    "category": paymentItem.item.category ?? ""
                ]
            })
                
            KarteTracker.shared.track("cart", values: [
                "total_price": totalPrice,
                "quantity": quantity,
                "items": items
            ])
        }
    }
}
