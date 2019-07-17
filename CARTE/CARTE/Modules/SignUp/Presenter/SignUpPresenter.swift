//
//  SignUpSignUpPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import FirebaseAuth

class SignUpPresenter {

    weak var view: SignUpViewInput!
    var interactor: SignUpInteractorInput!
    var router: SignUpRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    
    func viewDidAppear() {
        interactor.trackView()
    }
}

extension SignUpPresenter: SignUpViewOutput {
    
    func tapSignUpButton(identity: String?, password: String?, confirm: String?) {
        interactor.signUp(identity: identity, password: password)
    }
    
    func tapCloseButton() {
        router.close()
    }
}

extension SignUpPresenter: SignUpInteractorOutput {
    
    func signUpSuccess(_ result: AuthDataResult) {
        router.close()
    }
    
    func signUpFailure(_ error: Error) {
        // TODO: エラー処理
    }
}
