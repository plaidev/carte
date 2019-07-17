//
//  SearchResultSearchResultConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SearchResultModuleConfigurator {
    private let query: String
    
    init(query: String) {
        self.query = query
    }

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SearchResultViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SearchResultViewController) {

        let router = SearchResultRouter(viewController)

        let presenter = SearchResultPresenter(query: query)
        presenter.view = viewController
        presenter.router = router

        let interactor = SearchResultInteractor(
            itemRepository: ItemFirestoreRepository(),
            newItemRepository: NewItemFixtureRepository(),
            rankingRepository: RankingFixtureRepository()
        )
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
