//
//  TabTabPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 03/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

class TabPresenter {

    weak var view: TabViewInput!
    var interactor: TabInteractorInput!
    var router: TabRouterInput!

    func viewIsReady() {
        view.setupInitialState()
        interactor.trackLocation()
    }
}

extension TabPresenter: TabViewOutput {
    
}

extension TabPresenter: TabInteractorOutput {
    
    func signOutSuccess() {
        router.showSignIn()
    }
    
    func signOutFailure(_ error: Error) {
        
    }
}
