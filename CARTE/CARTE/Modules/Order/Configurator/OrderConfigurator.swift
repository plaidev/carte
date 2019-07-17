//
//  OrderOrderConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class OrderModuleConfigurator {
    private let paymentItems: [PaymentItem]
    
    init(paymentItems: [PaymentItem]) {
        self.paymentItems = paymentItems
    }

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? OrderViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: OrderViewController) {

        let router = OrderRouter(viewController)

        let presenter = OrderPresenter(paymentItems: paymentItems)
        presenter.view = viewController
        presenter.router = router

        let interactor = OrderInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
