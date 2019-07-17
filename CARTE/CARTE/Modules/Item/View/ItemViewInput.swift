//
//  ItemItemViewInput.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol ItemViewInput: class {
    func setupInitialState()
    func configureFavoriteButton(isFavorite: Bool)
}
