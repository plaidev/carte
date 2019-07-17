//
//  FavoriteFavoriteRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

class FavoriteRouter: FavoriteRouterInput {
    private weak var viewController: FavoriteViewController?
    
    init(_ viewController: FavoriteViewController) {
        self.viewController = viewController
    }

    func showItem(_ item: Item) {
        let viewController = ItemModuleInitializer(item: item).build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showCart() {
        let viewController = CartModuleInitializer().build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
