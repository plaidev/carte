//
//  MyPageMyPageRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class MyPageRouter: MyPageRouterInput {
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showSettingNotification() {
        let viewController = SettingNotificationModuleInitializer().build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showProfile() {
        let viewController = ProfileModuleInitializer().build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSignIn(fromSignOut: Bool) {
        guard fromSignOut else {
            let viewController = navi(SignInModuleInitializer().build())
            self.viewController?.present(viewController, animated: true, completion: nil)
            return
        }

        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        delegate.window?.rootViewController = navi(SignInModuleInitializer().build())
        delegate.window?.makeKeyAndVisible()
    }
}
