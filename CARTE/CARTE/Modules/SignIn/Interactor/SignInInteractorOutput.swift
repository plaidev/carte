//
//  SignInSignInInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol SignInInteractorOutput: class {
    func signInSuccess(_ result: AuthDataResult)
    func signInFailure(_ error: Error)
}
