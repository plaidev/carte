//
//  NewItemRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol NewItemRepository {
    func fetch() -> Single<[ItemId]>
}
