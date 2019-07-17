//
//  SearchSearchViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewInput {

    var output: SearchViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: SearchViewInput
    func setupInitialState() {
    }
}
