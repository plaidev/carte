//
//  InformationInformationViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, InformationViewInput {

    var output: InformationViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: InformationViewInput
    func setupInitialState() {
    }
}
