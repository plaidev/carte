//
//  CartCartConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class CartModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CartViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: CartViewController) {

        let router = CartRouter(viewController)

        let presenter = CartPresenter()
        presenter.view = viewController
        presenter.router = router

        let userId = UserId(id: Auth.auth().currentUser!.uid)
        let interactor = CartInteractor(
            cartRepository: CartFirestoreRepository(userId: userId),
            itemRepository: ItemFirestoreRepository(),
            userRepository: UserFirestoreRepository()
        )
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
