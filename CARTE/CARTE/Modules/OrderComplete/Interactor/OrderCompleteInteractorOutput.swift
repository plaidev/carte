//
//  OrderCompleteOrderCompleteInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol OrderCompleteInteractorOutput: class {
    func removedCartItems(_ event: SingleEvent<Void>)
}
