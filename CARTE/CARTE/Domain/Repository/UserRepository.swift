//
//  UserRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/13.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository {
    func retrieveUser(userId: UserId) -> Single<User>
    func updateUser(user: User) -> Single<Void>
}
