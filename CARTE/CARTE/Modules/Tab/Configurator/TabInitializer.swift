//
//  TabTabInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 03/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class TabModuleInitializer: NSObject {
    private let tab: Tab
    
    init(tab: Tab = .home(nil)) {
        self.tab = tab
        super.init()
    }
    
    func build() -> TabViewController {
        guard let viewController = R.storyboard.main.tabViewController() else {
            fatalError()
        }
        
        let configurator = TabModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        viewController.viewControllers = [
            buildHomeViewController(),
            buildFavoriteViewController(),
            buildSearchViewController(),
            buildInformationViewController(),
            buildMyPageViewController()
        ]
        
        viewController.selectedTab = tab
        
        return viewController
    }
}

extension TabModuleInitializer {
    
    private func buildHomeViewController() -> UIViewController {
        var content: HomeContent?
        if case let .home(value) = tab {
            content = value
        }
        
        let viewController = navi(HomeModuleInitializer(content: content).build())
        viewController.tabBarItem.title = "ホーム"
        viewController.tabBarItem.image = R.image.ic_tab_home_normal()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = R.image.ic_tab_home_highlight()?.withRenderingMode(.alwaysOriginal)
        return viewController
    }
    
    private func buildFavoriteViewController() -> UIViewController {
        let viewController = navi(FavoriteModuleInitializer().build())
        viewController.tabBarItem.title = "お気に入り"
        viewController.tabBarItem.image = R.image.ic_tab_favorite_normal()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = R.image.ic_tab_favorite_highlight()?.withRenderingMode(.alwaysOriginal)
        return viewController
    }
    
    private func buildSearchViewController() -> UIViewController {
        let viewController = navi(SearchModuleInitializer().build())
        viewController.tabBarItem.isEnabled = false
        viewController.tabBarItem.title = "さがす"
        viewController.tabBarItem.image = R.image.ic_tab_search_normal()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = R.image.ic_tab_search_highlight()?.withRenderingMode(.alwaysOriginal)
        return viewController
    }
    
    private func buildInformationViewController() -> UIViewController {
        let viewController = navi(InformationModuleInitializer().build())
        viewController.tabBarItem.isEnabled = false
        viewController.tabBarItem.title = "お知らせ"
        viewController.tabBarItem.image = R.image.ic_tab_information_normal()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = R.image.ic_tab_information_highlight()?.withRenderingMode(.alwaysOriginal)
        return viewController
    }
    
    private func buildMyPageViewController() -> UIViewController {
        let viewController = navi(MyPageModuleInitializer().build())
        viewController.tabBarItem.title = "マイページ"
        viewController.tabBarItem.image = R.image.ic_tab_mypage_normal()?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = R.image.ic_tab_mypage_highlight()?.withRenderingMode(.alwaysOriginal)
        return viewController
    }
}
