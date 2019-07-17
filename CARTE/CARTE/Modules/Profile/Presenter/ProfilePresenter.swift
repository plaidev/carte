//
//  ProfileProfilePresenter.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import FirebaseAuth

class ProfilePresenter: ProfileModuleInput {

    weak var view: ProfileViewInput!
    var interactor: ProfileInteractorInput!
    var router: ProfileRouterInput!

    private var user: User?
    
    func viewIsReady() {
        interactor.retrieveUser()
    }
    
    func viewDidAppear() {
        interactor.trackView()
    }
}

extension ProfilePresenter: ProfileViewOutput {
    
    var name: String? {
        get {
            return Auth.auth().currentUser?.displayName
        }
        set {
            let request = Auth.auth().currentUser?.createProfileChangeRequest()
            request?.displayName = newValue
            request?.commitChanges(completion: nil)
        }
    }
    
    var birthDate: Date? {
        get {
            return user?.birthDate
        }
        set {
            user?.birthDate = newValue
            if let user = user {
                interactor.updateUser(user)
            }
        }
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    
    func retrievedUser(_ event: SingleEvent<User>) {
        guard case let .success(user) = event else {
            return
        }
        self.user = user
        view.setupInitialState()
    }
}
