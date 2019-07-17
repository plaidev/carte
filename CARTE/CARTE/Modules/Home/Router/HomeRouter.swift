//
//  HomeHomeRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import SafariServices

class HomeRouter: HomeRouterInput {
    private weak var viewController: HomeViewController?
    
    init(_ viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func showCart() {
        let viewController = CartModuleInitializer().build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSearchResult(query: String) {
        let viewController = SearchResultModuleInitializer(query: query).build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showFeature(_ feature: Feature) {
        guard let url = feature.url else {
            return
        }
        
        let configuration = SFSafariViewController.Configuration()
        let viewController = SFSafariViewController(url: url, configuration: configuration)
        self.viewController?.present(viewController, animated: true, completion: nil)
    }
    
    func showItem(_ item: Item) {
        let viewController = ItemModuleInitializer(item: item).build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
