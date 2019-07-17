//
//  ItemItemRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

class ItemRouter: ItemRouterInput {
    weak var viewController: ItemViewController?
    
    init(_ viewController: ItemViewController) {
        self.viewController = viewController
    }
    
    func showCart() {
        let viewController = CartModuleInitializer().build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
