//
//  ProfileProfileInteractorOutput.swift
//  CARTE
//
//  Created by tomoponzoo on 13/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift

protocol ProfileInteractorOutput: class {
    func retrievedUser(_ event: SingleEvent<User>)
}
