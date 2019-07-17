//
//  SettingNotificationSettingNotificationViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 12/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol SettingNotificationViewOutput {
    var shopNotificationEnabled: Bool { get set }
    var brandNotificationEnabled: Bool { get set }
    var mailNotificationEnabled: Bool { get set }
    
    func viewIsReady()
    func viewDidAppear()
    func viewDidDisappear()
}
