//
//  SignInSignInViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController, SignInViewInput {
    @IBOutlet weak var identityTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var anonymousButton: UIButton!
    
    var output: SignInViewOutput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: SignInViewInput
    func setupInitialState() {
        anonymousButton.isHidden = Auth.auth().currentUser != nil
        if Auth.auth().currentUser == nil {
            navigationItem.rightBarButtonItems = []
        }
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func tapSignInButton(_ sender: UIButton) {
        output.tapSignInButton(identity: identityTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func tapSignInAnonymouslyButton(_ sender: UIButton) {
        output.tapSignInAnonymouslyButton()
    }
    
    @IBAction func tapSignUpButton(_ sender: UIButton) {
        output.tapSignUpButton()
    }
    
    @IBAction func tapCloseButton(_ sender: UIBarButtonItem) {
        output.tapCloseButton()
    }
}
