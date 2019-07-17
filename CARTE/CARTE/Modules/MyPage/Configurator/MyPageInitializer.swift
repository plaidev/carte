//
//  MyPageMyPageInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class MyPageModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> MyPageViewController {
        guard let viewController = R.storyboard.main.myPageViewController() else {
            fatalError()
        }
        
        let configurator = MyPageModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
