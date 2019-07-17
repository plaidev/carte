//
//  ItemItemInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol ItemInteractorInput {
    func addCart(item: Item)
    func addFavorite(item: Item)
    func removeFavorite(item: Item)
    func isFavorite(item: Item)
    
    func trackView(item: Item)
    func trackCartEvent()
    func trackFavoriteEvent()
}
