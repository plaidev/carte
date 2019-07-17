//
//  TabTabInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 03/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol TabInteractorOutput: class {
    func signOutSuccess()
    func signOutFailure(_ error: Error)
}
