//
//  SignInSignInInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SignInModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> SignInViewController {
        guard let viewController = R.storyboard.main.signInViewController() else {
            fatalError()
        }
        
        let configurator = SignInModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
