//
//  ProfileProfileInitializer.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class ProfileModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> ProfileViewController {
        guard let viewController = R.storyboard.main.profileViewController() else {
            fatalError()
        }
        
        let configurator = ProfileModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
