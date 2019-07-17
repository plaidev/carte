//
//  SignUpSignUpConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SignUpViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SignUpViewController) {

        let router = SignUpRouter(viewController, hasUserId: Auth.auth().currentUser != nil)

        let presenter = SignUpPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SignUpInteractor(userRepository: UserFirestoreRepository())
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
