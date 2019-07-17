//
//  SignInSignInConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SignInViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SignInViewController) {

        let router = SignInRouter(viewController, hasUserId: Auth.auth().currentUser != nil)

        let presenter = SignInPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SignInInteractor(userRepository: UserFirestoreRepository())
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
