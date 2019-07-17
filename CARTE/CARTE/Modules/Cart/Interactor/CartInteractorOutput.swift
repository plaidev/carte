//
//  CartCartInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol CartInteractorOutput: class {
    func fetchedPaymentItems(_ event: SingleEvent<[PaymentItem]>)
    func removedPaymentItem(_ event: SingleEvent<Void>)
    func retrievedPoint(_ point: Int)
}
