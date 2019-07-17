//
//  SignInSignInInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol SignInInteractorInput {
    func signIn(identity: String?, password: String?)
    func signInAnonymously()
    func trackView()
}
