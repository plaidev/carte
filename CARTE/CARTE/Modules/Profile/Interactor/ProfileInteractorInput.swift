//
//  ProfileProfileInteractorInput.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol ProfileInteractorInput {
    func retrieveUser()
    func updateUser(_ user: User)
    func trackView()
}
