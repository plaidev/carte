//
//  OrderCompleteOrderCompleteInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class OrderCompleteModuleInitializer: NSObject {
    private let paymentItems: [PaymentItem]
    
    init(paymentItems: [PaymentItem]) {
        self.paymentItems = paymentItems
    }

    func build() -> OrderCompleteViewController {
        guard let viewController = R.storyboard.main.orderCompleteViewController() else {
            fatalError()
        }
        
        let configurator = OrderCompleteModuleConfigurator(paymentItems: paymentItems)
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
    
}
