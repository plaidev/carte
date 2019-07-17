//
//  CartCartViewInput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol CartViewInput: class {
    func setupInitialState()
    func refreshPoint(_ point: Int)
}
