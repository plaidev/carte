//
//  SignInSignInPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import FirebaseAuth

class SignInPresenter: SignInModuleInput {

    weak var view: SignInViewInput!
    var interactor: SignInInteractorInput!
    var router: SignInRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    
    func viewDidAppear() {
        interactor.trackView()
    }
}

extension SignInPresenter: SignInViewOutput {
    
    func tapSignInButton(identity: String?, password: String?) {
        interactor.signIn(identity: identity, password: password)
    }
    
    func tapSignInAnonymouslyButton() {
        interactor.signInAnonymously()
    }
    
    func tapSignUpButton() {
        router.showSignUp()
    }
    
    func tapCloseButton() {
        router.close()
    }
}

extension SignInPresenter: SignInInteractorOutput {
    
    func signInSuccess(_ result: AuthDataResult) {
        router.close()
    }
    
    func signInFailure(_ error: Error) {
        // TODO: エラー処理
    }
}
