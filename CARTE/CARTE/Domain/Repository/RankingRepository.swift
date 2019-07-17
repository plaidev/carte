//
//  RankingRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol RankingRepository {
    func fetch() -> Single<[ItemId]>
}
