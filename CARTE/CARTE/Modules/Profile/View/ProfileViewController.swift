//
//  ProfileProfileViewController.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, ProfileViewInput {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthDateLabel: BirthDateLabel!
    
    var output: ProfileViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: ProfileViewInput
    func setupInitialState() {
        nameTextField.text = output.name
        birthDateLabel.delegate = self
        birthDateLabel.date = output.birthDate ?? Date()
    }
}

extension ProfileViewController: BirthDateLabelDelegate {
    
    func birthDateLabel(_ label: BirthDateLabel, didSubmitBirthDate birthDate: Date) {
        output.birthDate = birthDate
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        output.name = textField.text
        textField.resignFirstResponder()
        return true
    }
}
