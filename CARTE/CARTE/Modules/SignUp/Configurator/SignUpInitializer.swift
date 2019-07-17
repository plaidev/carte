//
//  SignUpSignUpInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SignUpModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> SignUpViewController {
        guard let viewController = R.storyboard.main.signUpViewController() else {
            fatalError()
        }
        
        let configurator = SignUpModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
