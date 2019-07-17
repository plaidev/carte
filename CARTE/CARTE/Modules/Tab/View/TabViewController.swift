//
//  TabTabViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 03/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, TabViewInput {

    var output: TabViewOutput!

    var selectedTab: Tab = .home(nil) {
        didSet {
            selectedIndex = selectedTab.index
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: TabViewInput
    func setupInitialState() {
    }
}
