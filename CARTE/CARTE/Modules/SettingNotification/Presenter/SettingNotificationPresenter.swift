//
//  SettingNotificationSettingNotificationPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 12/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

class SettingNotificationPresenter: SettingNotificationModuleInput {

    weak var view: SettingNotificationViewInput!
    var interactor: SettingNotificationInteractorInput!
    var router: SettingNotificationRouterInput!
    
    private var user: User?

    func viewIsReady() {
        interactor.retrieveUser()
    }
    
    func viewDidAppear() {
        interactor.trackView()
    }
    
    func viewDidDisappear() {
        guard let user = user else {
            return
        }
        interactor.updateUser(user: user)
    }
}

extension SettingNotificationPresenter: SettingNotificationViewOutput {
    
    var shopNotificationEnabled: Bool {
        get {
            return user?.shopNotification ?? false
        }
        set {
            user?.shopNotification = newValue
        }
    }
    
    var brandNotificationEnabled: Bool {
        get {
            return user?.brandNotification ?? false
        }
        set {
            user?.brandNotification = newValue
        }
    }
    
    var mailNotificationEnabled: Bool {
        get {
            return user?.subscription ?? false
        }
        set {
            user?.subscription = newValue
        }
    }
}

extension SettingNotificationPresenter: SettingNotificationInteractorOutput {
    
    func retrievedUser(_ event: SingleEvent<User>) {
        guard case let .success(user) = event else {
            return
        }
        
        self.user = user
        view.setupInitialState()
    }
}
