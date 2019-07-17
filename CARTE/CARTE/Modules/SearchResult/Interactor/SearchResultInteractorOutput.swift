//
//  SearchResultSearchResultInteractorOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol SearchResultInteractorOutput: class {
    func searched(_ items: [Item])
}
