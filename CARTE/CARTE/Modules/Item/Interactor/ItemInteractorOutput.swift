//
//  ItemItemInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol ItemInteractorOutput: class {
    func addedCart(_ event: SingleEvent<Void>)
    func addedFavorite(_ event: SingleEvent<Void>)
    func removedFavorite(_ event: SingleEvent<Void>)
    func containedFavorite(_ event: SingleEvent<Bool>)
}
