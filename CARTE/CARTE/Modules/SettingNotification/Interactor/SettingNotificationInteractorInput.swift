//
//  SettingNotificationSettingNotificationInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 12/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol SettingNotificationInteractorInput {
    func retrieveUser()
    func updateUser(user: User)
    func trackView()
}
