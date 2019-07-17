//
//  SignInSignInInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import FirebaseAuth
import FirebaseAnalytics
import KarteTracker

class SignInInteractor: SignInInteractorInput {
    private let userRepository: UserRepository

    weak var output: SignInInteractorOutput!
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func signIn(identity: String?, password: String?) {
        Auth.auth().signIn(withEmail: identity ?? "", password: password ?? "") { (result, error) in
            if let error = error {
                self.output.signInFailure(error)
            } else if let result = result {
                KarteTracker.shared.identify([
                    "user_id": result.user.uid,
                    "login": true
                ])
                self.output.signInSuccess(result)
            }
        }
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error {
                self.output.signInFailure(error)
            } else if let result = result {
                let user = User(
                    id: UserId(id: result.user.uid),
                    anonymous: true,
                    subscription: false,
                    shopNotification: true,
                    brandNotification: true,
                    birthDate: nil,
                    point: 500
                )
                _ = self.userRepository.updateUser(user: user).subscribe { [weak self] (event) in
                    self?.output.signInSuccess(result)
                    
                    KarteTracker.shared.identify([
                        "login": false,
                        "subscription": user.subscription,
                        "notification_shop": user.shopNotification,
                        "notification_brand": user.brandNotification,
                        "point": user.point
                    ])
                }
            }
        }
    }
    
    func trackView() {
        KarteTracker.shared.view("signin", title: "サインイン", values: [
            "view_id": "signin"
        ])
    }
}
