//
//  SettingNotificationSettingNotificationViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 12/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SettingNotificationViewController: UITableViewController, SettingNotificationViewInput {
    @IBOutlet weak var shopNotificationSwitch: UISwitch!
    @IBOutlet weak var brandNotificationSwitch: UISwitch!
    @IBOutlet weak var mailNotificationSwitch: UISwitch!
    
    var output: SettingNotificationViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output.viewDidDisappear()
    }

    // MARK: SettingNotificationViewInput
    func setupInitialState() {
        shopNotificationSwitch.isOn = output.shopNotificationEnabled
        shopNotificationSwitch.isEnabled = true
        brandNotificationSwitch.isOn = output.brandNotificationEnabled
        brandNotificationSwitch.isEnabled = true
        mailNotificationSwitch.isOn = output.mailNotificationEnabled
        mailNotificationSwitch.isEnabled = true
    }
    
    @IBAction func changeShopNotificationEnableValue(_ sender: UISwitch) {
        output.shopNotificationEnabled = sender.isOn
    }
    
    @IBAction func changeBrandNotificationEnableValue(_ sender: UISwitch) {
        output.brandNotificationEnabled = sender.isOn
    }
    
    @IBAction func changeMailNotificationEnableValue(_ sender: UISwitch) {
        output.mailNotificationEnabled = sender.isOn
    }
}
