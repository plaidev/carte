//
//  FavoriteFavoriteInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class FavoriteModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> FavoriteViewController {
        guard let viewController = R.storyboard.main.favoriteViewController() else {
            fatalError()
        }
        
        let configurator = FavoriteModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
