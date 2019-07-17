//
//  FavoriteFavoriteViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol FavoriteViewOutput {
    var numberOfItems: Int { get }
    func viewIsReady()
    func viewWillAppear()
    func viewDidAppear()
    func itemAt(_ index: Int) -> Item
    func tapItemAt(_ index: Int)
    func tapCartButton()
}
