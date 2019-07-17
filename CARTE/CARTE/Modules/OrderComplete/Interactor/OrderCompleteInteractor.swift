//
//  OrderCompleteOrderCompleteInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import FirebaseAuth
import KarteTracker

class OrderCompleteInteractor: OrderCompleteInteractorInput {

    weak var output: OrderCompleteInteractorOutput!

    private let cartRepository: CartRepository
    private let userRepository: UserRepository
    
    init(cartRepository: CartRepository, userRepository: UserRepository) {
        self.cartRepository = cartRepository
        self.userRepository = userRepository
    }
    
    func removeCartItems(paymentItems: [PaymentItem]) {
        let itemIds = paymentItems.map { $0.item.id }
        _ = cartRepository.removeAll(itemIds: itemIds).subscribe { [weak self] (event) in
            self?.output.removedCartItems(event)
        }
    }
    
    func givePoints(paymentItems: [PaymentItem]) {
        guard let fuser = Auth.auth().currentUser else {
            return
        }
        
        let point = paymentItems.reduce(0) { (total, paymentItem) -> Int in
            return total + paymentItem.price.value
        } / 100
        
        let userRepository = self.userRepository
        _ = userRepository.retrieveUser(userId: UserId(id: fuser.uid)).flatMap { (user) -> PrimitiveSequence<SingleTrait, Void> in
            var user = user
            user.point += point
            KarteTracker.shared.identify(["point": user.point])
            return userRepository.updateUser(user: user)
        }.subscribe()
    }
}
