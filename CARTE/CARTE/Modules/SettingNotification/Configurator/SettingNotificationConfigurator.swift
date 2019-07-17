//
//  SettingNotificationSettingNotificationConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 12/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SettingNotificationModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SettingNotificationViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SettingNotificationViewController) {

        let router = SettingNotificationRouter()

        let presenter = SettingNotificationPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SettingNotificationInteractor(userRepository: UserFirestoreRepository())
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
