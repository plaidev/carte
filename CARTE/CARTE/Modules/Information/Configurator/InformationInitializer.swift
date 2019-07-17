//
//  InformationInformationInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class InformationModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> InformationViewController {
        guard let viewController = R.storyboard.main.informationViewController() else {
            fatalError()
        }
        
        let configurator = InformationModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
