//
//  SearchSearchInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SearchModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> SearchViewController {
        guard let viewController = R.storyboard.main.searchViewController() else {
            fatalError()
        }
        
        let configurator = SearchModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
