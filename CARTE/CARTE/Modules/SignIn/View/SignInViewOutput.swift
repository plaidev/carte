//
//  SignInSignInViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol SignInViewOutput {
    func viewIsReady()
    func viewDidAppear()
    
    func tapSignInButton(identity: String?, password: String?)
    func tapSignInAnonymouslyButton()
    func tapSignUpButton()
    func tapCloseButton()
}
