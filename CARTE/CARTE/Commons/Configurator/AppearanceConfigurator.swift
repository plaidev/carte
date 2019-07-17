//
//  AppearanceConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/03.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class AppearanceConfigurator {
    
    static func configure() {
        // UINavigationBar
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = R.color.button_secondary()
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: R.color.tabbar_title_normal()!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        
        // UITabBarItem
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.color.tabbar_title_normal()!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)
        ], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: R.color.tabbar_title_highlight()!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)
        ], for: .highlighted)
    }
}
