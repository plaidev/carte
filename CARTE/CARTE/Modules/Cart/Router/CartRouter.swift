//
//  CartCartRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class CartRouter: CartRouterInput {
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showOrder(paymentItems: [PaymentItem]) {
        let viewController = OrderModuleInitializer(paymentItems: paymentItems).build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func close() {
        self.viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
