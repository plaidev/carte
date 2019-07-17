//
//  OrderOrderRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class OrderRouter: OrderRouterInput {
    weak var viewController: UIViewController?

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showOrderComplete(paymentItems: [PaymentItem]) {
        let viewController = OrderCompleteModuleInitializer(paymentItems: paymentItems).build()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func close() {
        self.viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
