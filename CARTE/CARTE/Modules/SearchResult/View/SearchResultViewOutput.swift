//
//  SearchResultSearchResultViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

protocol SearchResultViewOutput {
    var query: String { get }
    
    func viewIsReady()
    func viewDidAppear()
    
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func itemAt(_ index: Int) -> Item
    
    func tapItemAt(_ index: Int)
    func tapCartButton()
}
