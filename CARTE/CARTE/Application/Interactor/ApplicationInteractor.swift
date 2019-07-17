//
//  ApplicationInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/13.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAnalytics
import FirebaseAuth
import FirebaseInstanceID
import KarteTracker

class ApplicationInteractor: ApplicationInteractorInput {
    private let userRepository: UserRepository
    
    weak var output: ApplicationInteractorOutput!
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func signOutIfNeeded() {
        if !UserDefaults.standard.bool(forKey: "INITIALIZED") {
            if let _ = Auth.auth().currentUser {
                // 初回起動なのにユーザーがある場合は、再インストール後の起動であるのでサインアウトする
                try! Auth.auth().signOut()
            }
            UserDefaults.standard.set(true, forKey: "INITIALIZED")
            UserDefaults.standard.synchronize()
        }
    }
    
    func trackIdentify() {
        InstanceID.instanceID().getID { (id, error) in
            guard let id = id else {
                return
            }
            KarteTracker.shared.identify([
                "instance_id": id
            ])
        }
        
        guard let fusr = Auth.auth().currentUser else {
            KarteTracker.shared.identify([
                "login": false
            ])
            return
        }
        
        let userRepository = UserFirestoreRepository()
        _ = userRepository.retrieveUser(userId: UserId(id: fusr.uid)).subscribe { (event) in
            guard case let .success(user) = event else {
                return
            }
            
            var values: [AnyHashable: Any] = [
                "point": user.point,
                "subscription": user.subscription,
                "notification_brand": user.brandNotification,
                "notification_shop": user.shopNotification,
            ]
            
            if let birthDate = user.birthDate {
                values["birth_date"] = birthDate
            }
            if let name = fusr.displayName {
                values["name"] = name
            }
            if user.anonymous {
                values["login"] = false
            } else {
                values["user_id"] = user.id.id
                values["login"] = true
                if let email = fusr.email {
                    values["email"] = email
                }
                if let registeredDate = fusr.metadata.creationDate {
                    values["registered_date"] = registeredDate
                }
            }
            KarteTracker.shared.identify(values)
        }
    }
}
