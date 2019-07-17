//
//  SettingNotificationSettingNotificationInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 12/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import FirebaseAuth
import FirebaseAnalytics
import KarteTracker

class SettingNotificationInteractor: SettingNotificationInteractorInput {
    private let userRepository: UserRepository
    
    weak var output: SettingNotificationInteractorOutput!

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func retrieveUser() {
        let userId = UserId(id: Auth.auth().currentUser!.uid)
        _ = userRepository.retrieveUser(userId: userId).subscribe { [weak self] (event) in
            self?.output.retrievedUser(event)
        }
    }
    
    func updateUser(user: User) {
        _ = userRepository.updateUser(user: user).subscribe { (event) in
            guard case .success = event else {
                return
            }
            KarteTracker.shared.identify([
                "subscription": user.subscription,
                "notification_shop": user.shopNotification,
                "notification_brand": user.brandNotification
            ])
        }
    }
    
    func trackView() {
        KarteTracker.shared.view("setting_notification", title: "通知設定", values: [
            "view_id": "setting_notification"
        ])
    }
}
