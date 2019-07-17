//
//  FavoriteFavoriteConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class FavoriteModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? FavoriteViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: FavoriteViewController) {

        let router = FavoriteRouter(viewController)

        let presenter = FavoritePresenter()
        presenter.view = viewController
        presenter.router = router

        let userId = UserId(id: Auth.auth().currentUser!.uid)
        let interactor = FavoriteInteractor(
            favoriteRepository: FavoriteFirestoreRepository(userId: userId),
            itemRepository: ItemFirestoreRepository()
        )
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
