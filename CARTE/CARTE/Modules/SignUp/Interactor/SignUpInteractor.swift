//
//  SignUpSignUpInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import FirebaseAuth
import FirebaseAnalytics
import KarteTracker

class SignUpInteractor: SignUpInteractorInput {
    private let userRepository: UserRepository

    weak var output: SignUpInteractorOutput!
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func signUp(identity: String?, password: String?) {
        Auth.auth().createUser(withEmail: identity ?? "", password: password ?? "") { (result, error) in
            if let error = error {
                self.output.signUpFailure(error)
            } else if let result = result {
                let user = User(
                    id: UserId(id: result.user.uid),
                    anonymous: false,
                    subscription: true,
                    shopNotification: true,
                    brandNotification: true,
                    birthDate: nil,
                    point: 500
                )
                _ = self.userRepository.updateUser(user: user).subscribe { [weak self] (event) in
                    self?.output.signUpSuccess(result)

                    KarteTracker.shared.identify([
                        "user_id": result.user.uid,
                        "login": true,
                        "subscription": user.subscription,
                        "notification_shop": user.shopNotification,
                        "notification_brand": user.brandNotification,
                        "point": user.point,
                        "registered_date": result.user.metadata.creationDate!
                    ])
                }
            }
        }
    }
    
    func trackView() {
        KarteTracker.shared.view("signup", title: "サインアップ", values: [
            "view_id": "signup"
        ])
    }
}
