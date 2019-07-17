//
//  TabTabRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 03/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class TabRouter: TabRouterInput {

    func showSignIn() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        delegate.window?.rootViewController = navi(SignInModuleInitializer().build())
        delegate.window?.makeKeyAndVisible()
    }
}
