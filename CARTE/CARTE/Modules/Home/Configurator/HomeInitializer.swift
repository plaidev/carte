//
//  HomeHomeInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class HomeModuleInitializer: NSObject {
    private let content: HomeContent?
    
    init(content: HomeContent?) {
        self.content = content
        super.init()
    }
    
    func build() -> HomeViewController {
        guard let viewController = R.storyboard.main.homeViewController() else {
            fatalError()
        }
        
        let configurator = HomeModuleConfigurator(content: content)
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
