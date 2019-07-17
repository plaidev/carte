//
//  CartRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol CartRepository {
    func fetchAll() -> Single<[ItemId]>
    func add(itemId: ItemId) -> Single<Void>
    func remove(itemId: ItemId) -> Single<Void>
    func removeAll(itemIds: [ItemId]) -> Single<Void>
}
