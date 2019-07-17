//
//  ProfileProfileViewOutput.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol ProfileViewOutput {
    var name: String? { get set }
    var birthDate: Date? { get set }
    
    func viewIsReady()
    func viewDidAppear()
}
