//
//  TabTabConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 03/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class TabModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? TabViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: TabViewController) {

        let router = TabRouter()

        let presenter = TabPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = TabInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
