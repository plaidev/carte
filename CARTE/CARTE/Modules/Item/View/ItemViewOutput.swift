//
//  ItemItemViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol ItemViewOutput {
    var item: Item { get }
    
    func viewIsReady()
    func viewDidAppear()
    
    func tapCartButton()
    func tapAddCartButton()
    func tapFavoriteButton(isFavorite: Bool)
    
    func row(index: Int) -> ItemPresenter.Row
    
    // TableViewDataSource
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
}
