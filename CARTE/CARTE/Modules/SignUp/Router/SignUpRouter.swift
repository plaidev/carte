//
//  SignUpSignUpRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SignUpRouter: SignUpRouterInput {
    private weak var viewController: SignUpViewController?
    private var hasUserId: Bool
    
    init(_ viewController: SignUpViewController, hasUserId: Bool) {
        self.viewController = viewController
        self.hasUserId = hasUserId
    }
    
    func close() {
        if hasUserId {
            self.viewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else {
            fatalError()
        }
        
        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve, .curveLinear], animations: {
            window.rootViewController = TabModuleInitializer().build()
        }, completion: nil)
    }
}
