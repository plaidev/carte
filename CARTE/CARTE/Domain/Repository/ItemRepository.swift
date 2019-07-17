//
//  ItemRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol ItemRepository {
    func fetchAllItems() -> Single<[Item]>
    func fetchAllItemIds() -> Single<[ItemId]>
    func fetchItems(itemIds: [ItemId]) -> Single<[Item]>
    func fetchItem(itemId: ItemId) -> Single<Item>
}
