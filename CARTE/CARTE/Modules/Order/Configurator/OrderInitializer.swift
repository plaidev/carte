//
//  OrderOrderInitializer.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class OrderModuleInitializer: NSObject {
    private let paymentItems: [PaymentItem]

    init(paymentItems: [PaymentItem]) {
        self.paymentItems = paymentItems
    }
    
    func build() -> OrderViewController {
        guard let viewController = R.storyboard.main.orderViewController() else {
            fatalError()
        }
        
        let configurator = OrderModuleConfigurator(paymentItems: paymentItems)
        configurator.configureModuleForViewInput(viewInput: viewController)
        
        return viewController
    }
    
}
