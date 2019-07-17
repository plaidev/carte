//
//  CartCartInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class CartModuleInitializer: NSObject {

    func build() -> CartViewController {
        guard let viewController = R.storyboard.main.cartViewController() else {
            fatalError()
        }
        
        let configurator = CartModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }

}
