//
//  OrderCompleteOrderCompleteConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class OrderCompleteModuleConfigurator {
    private let paymentItems: [PaymentItem]
    
    init(paymentItems: [PaymentItem]) {
        self.paymentItems = paymentItems
    }

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? OrderCompleteViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: OrderCompleteViewController) {

        let router = OrderCompleteRouter(viewController)

        let presenter = OrderCompletePresenter(paymentItems: paymentItems)
        presenter.view = viewController
        presenter.router = router

        let userId = UserId(id: Auth.auth().currentUser!.uid)
        let interactor = OrderCompleteInteractor(
            cartRepository: CartFirestoreRepository(userId: userId),
            userRepository: UserFirestoreRepository()
        )
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
