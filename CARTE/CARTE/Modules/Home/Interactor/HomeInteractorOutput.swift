//
//  HomeHomeInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeInteractorOutput: class {
    func fetched(features: [Feature], newItems: [Item], rankingItems: [Item])
    func fetchedItem(_ event: SingleEvent<Item>)
}
