//
//  NewItemFixtureRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

class NewItemFixtureRepository: NewItemRepository {

    func fetch() -> Single<[ItemId]> {
        let itemIds = [
            ItemId(id: "001"),
            ItemId(id: "002"),
            ItemId(id: "003"),
            ItemId(id: "004"),
            ItemId(id: "005"),
            ItemId(id: "006")
        ]
        
        return Single.just(itemIds)
    }
}
