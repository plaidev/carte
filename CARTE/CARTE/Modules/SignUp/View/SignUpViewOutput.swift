//
//  SignUpSignUpViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol SignUpViewOutput {
    func viewIsReady()
    func viewDidAppear()
    func tapSignUpButton(identity: String?, password: String?, confirm: String?)
    func tapCloseButton()
}
