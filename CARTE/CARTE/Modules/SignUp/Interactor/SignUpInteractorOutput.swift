//
//  SignUpSignUpInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol SignUpInteractorOutput: class {
    func signUpSuccess(_ result: AuthDataResult)
    func signUpFailure(_ error: Error)
}
