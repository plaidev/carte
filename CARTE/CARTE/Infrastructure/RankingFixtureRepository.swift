//
//  RankingFixtureRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

class RankingFixtureRepository: RankingRepository {
    
    func fetch() -> Single<[ItemId]> {
        let itemIds = [
            ItemId(id: "007"),
            ItemId(id: "008"),
            ItemId(id: "009"),
            ItemId(id: "010"),
            ItemId(id: "011"),
            ItemId(id: "012")
        ]
        
        return Single.just(itemIds)
    }
}
