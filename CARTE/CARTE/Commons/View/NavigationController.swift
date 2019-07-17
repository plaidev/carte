//
//  NavigationController.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/03.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

func navi(_ viewControllers: UIViewController...) -> NavigationController {
    let navigationController: NavigationController
    if viewControllers.count == 1 {
        navigationController = NavigationController(rootViewController: viewControllers[0])
    } else {
        navigationController = NavigationController()
        navigationController.viewControllers = viewControllers
    }
    return navigationController
}

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        if let viewController = viewControllers.last {
            clearBackBarButtonItemText(viewController)
        }
    }
}

extension NavigationController {
    
    private func clearBackBarButtonItemText(_ viewController: UIViewController) {
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = ""
        viewController.navigationItem.backBarButtonItem = backBarButtonItem
        viewController.navigationItem.backBarButtonItem?.isEnabled = true
    }
}

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        clearBackBarButtonItemText(viewController)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    }
}
