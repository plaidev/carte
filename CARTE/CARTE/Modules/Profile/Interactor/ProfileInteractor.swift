//
//  ProfileProfileInteractor.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import FirebaseAuth
import KarteTracker

class ProfileInteractor: ProfileInteractorInput {
    private let userRepository: UserRepository

    weak var output: ProfileInteractorOutput!
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func retrieveUser() {
        let userId = UserId(id: Auth.auth().currentUser!.uid)
        _ = userRepository.retrieveUser(userId: userId).subscribe { [weak self] (event) in
            self?.output.retrievedUser(event)
        }
    }
    
    func updateUser(_ user: User) {
        _ = userRepository.updateUser(user: user).subscribe()
    }
    
    func trackView() {
        KarteTracker.shared.view("profile", title: "プロフィール設定", values: [
            "view_id": "profile"
        ])
    }
}
