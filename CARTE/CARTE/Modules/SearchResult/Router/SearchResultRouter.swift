//
//  SearchResultSearchResultRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

class SearchResultRouter: SearchResultRouterInput {
    private weak var viewController: SearchResultViewController?
    
    init(_ viewController: SearchResultViewController) {
        self.viewController = viewController
    }
    
    func showItem(item: Item) {
        let viewController = ItemModuleInitializer(item: item).build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showCart() {
        let viewController = CartModuleInitializer().build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
