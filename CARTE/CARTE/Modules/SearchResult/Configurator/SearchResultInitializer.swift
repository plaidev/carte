//
//  SearchResultSearchResultInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SearchResultModuleInitializer: NSObject {
    private let query: String
    
    init(query: String) {
        self.query = query
        super.init()
    }
    
    func build() -> SearchResultViewController {
        guard let viewController = R.storyboard.main.searchResultViewController() else {
            fatalError()
        }
        
        let configurator = SearchResultModuleConfigurator(query: query)
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
