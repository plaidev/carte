//
//  SearchResultSearchResultInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol SearchResultInteractorInput {
    func search(query: String)
    func trackView(query: String)
}
