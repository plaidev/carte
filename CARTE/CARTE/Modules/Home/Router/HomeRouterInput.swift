//
//  HomeHomeRouterInput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol HomeRouterInput {
    func showCart()
    func showSearchResult(query: String)
    func showFeature(_ feature: Feature)
    func showItem(_ item: Item)
}
