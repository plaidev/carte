//
//  HomeHomeConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class HomeModuleConfigurator {
    private let content: HomeContent?
    
    init(content: HomeContent?) {
        self.content = content
    }

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HomeViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: HomeViewController) {

        let router = HomeRouter(viewController)

        let presenter = HomePresenter(content: content)
        presenter.view = viewController
        presenter.router = router

        let interactor = HomeInteractor(
            featureRepository: FeatureFixtureRepository(),
            itemRepository: ItemFirestoreRepository(),
            newItemRepository: NewItemFixtureRepository(),
            rankingRepository: RankingFixtureRepository()
        )
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
