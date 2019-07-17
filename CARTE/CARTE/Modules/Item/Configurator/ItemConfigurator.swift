//
//  ItemItemConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class ItemModuleConfigurator {
    private let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ItemViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ItemViewController) {

        let router = ItemRouter(viewController)

        let presenter = ItemPresenter(item: item)
        presenter.view = viewController
        presenter.router = router
        
        let userId = UserId(id: Auth.auth().currentUser!.uid)
        let interactor = ItemInteractor(
            cartRepository: CartFirestoreRepository(userId: userId),
            favoriteRepository: FavoriteFirestoreRepository(userId: userId), itemRepository: ItemFirestoreRepository()
        )
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
