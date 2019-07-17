//
//  SettingNotificationSettingNotificationInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 12/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SettingNotificationModuleInitializer: NSObject {

    override init() {
        super.init()
    }
    
    func build() -> SettingNotificationViewController {
        guard let viewController = R.storyboard.main.settingNotificationViewController() else {
            fatalError()
        }
        
        let configurator = SettingNotificationModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
}
