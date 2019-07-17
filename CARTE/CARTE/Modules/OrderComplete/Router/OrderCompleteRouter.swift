//
//  OrderCompleteOrderCompleteRouter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class OrderCompleteRouter: OrderCompleteRouterInput {
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func close() {
        self.viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
