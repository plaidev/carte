//
//  MyPageMyPageConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class MyPageModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? MyPageViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: MyPageViewController) {

        let router = MyPageRouter(viewController)

        let presenter = MyPagePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = MyPageInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
