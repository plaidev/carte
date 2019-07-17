//
//  ItemItemInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import FirebaseAuth
import FirebaseAnalytics
import FirebaseFirestore
import RxSwift
import KarteTracker

class ItemInteractor: ItemInteractorInput {

    weak var output: ItemInteractorOutput!

    private let cartRepository: CartRepository
    private let favoriteRepository: FavoriteRepository
    private let itemRepository: ItemRepository
    
    init(cartRepository: CartRepository, favoriteRepository: FavoriteRepository, itemRepository: ItemRepository) {
        self.cartRepository = cartRepository
        self.favoriteRepository = favoriteRepository
        self.itemRepository = itemRepository
    }
    
    func addCart(item: Item) {
        _ = cartRepository.add(itemId: item.id).subscribe { [weak self] (event) in
            self?.output.addedCart(event)
        }
    }
    
    func addFavorite(item: Item) {
        _ = favoriteRepository.add(itemId: item.id).subscribe { [weak self] (event) in
            self?.output.addedFavorite(event)
        }
    }
    
    func removeFavorite(item: Item) {
        _ = favoriteRepository.remove(itemId: item.id).subscribe { [weak self] (event) in
            self?.output.removedFavorite(event)
        }
    }
    
    func isFavorite(item: Item) {
        _ = favoriteRepository.contains(itemId: item.id).subscribe { [weak self] (event) in
            self?.output.containedFavorite(event)
        }
    }
    
    func trackView(item: Item) {
        KarteTracker.shared.view("view_detail", title: "商品詳細", values: [
            "view_id": "item\(item.id.id)"
        ])
        KarteTracker.shared.track("view_detail", values: [
            "item_id": item.id.id,
            "item_name": item.name,
            "brand_name": item.brand,
            "price": item.price.value,
            "item_image_url": item.image.middle?.source ?? "",
            "category": item.category ?? "unknown"
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
    
    func trackFavoriteEvent() {
        let itemRepository = self.itemRepository
        _ = favoriteRepository.fetchAll().flatMap { (itemIds) -> PrimitiveSequence<SingleTrait, [Item]> in
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
            
            KarteTracker.shared.track("favorite", values: [
                "quantity": quantity,
                "items": items
            ])
        }
    }
}
