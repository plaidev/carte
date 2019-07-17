//
//  ProfileProfileConfigurator.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class ProfileModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ProfileViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ProfileViewController) {

        let router = ProfileRouter()

        let presenter = ProfilePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ProfileInteractor(userRepository: UserFirestoreRepository())
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
