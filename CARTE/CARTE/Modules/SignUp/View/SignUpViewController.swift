//
//  SignUpSignUpViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, SignUpViewInput {
    @IBOutlet weak var identityTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    var output: SignUpViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: SignUpViewInput
    func setupInitialState() {
        if Auth.auth().currentUser == nil {
            navigationItem.rightBarButtonItems = []
        }
    }
    
    @IBAction func tapSignUpButton(_ sender: UIButton) {
        output.tapSignUpButton(
            identity: identityTextField.text,
            password: passwordTextField.text,
            confirm: passwordConfirmTextField.text
        )
    }
    
    @IBAction func tapCloseButton(_ sender: UIBarButtonItem) {
        output.tapCloseButton()
    }
}
