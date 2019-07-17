//
//  ItemItemInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class ItemModuleInitializer: NSObject {
    private let item: Item
    
    init(item: Item) {
        self.item = item
        super.init()
    }
    
    func build() -> ItemViewController {
        guard let viewController = R.storyboard.main.itemViewController() else {
            fatalError()
        }
        
        let configurator = ItemModuleConfigurator(item: item)
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
