//
//  ApplicationInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/13.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol ApplicationInteractorInput {
    func signOutIfNeeded()
    func trackIdentify()
}
