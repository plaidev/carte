//
//  HomeHomeViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

protocol HomeViewOutput {
    func viewIsReady()
    func viewDidAppear()
    func search(query: String)
    
    func tapCartButton()
    func tapFeatureAt(_ index: Int)
    func tapNewItemAt(_ index: Int)
    func tapRankingItemAt(_ index: Int)
    
    // CollectionViewDataSource
    func section(_ section: Int) -> HomePresenter.Section
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func featureAt(_ index: Int) -> Feature
    func newItemAt(_ index: Int) -> Item
    func rankingItemAt(_ index: Int) -> Item
    func rank(_ index: Int) -> Int
    func sectionHeaderTitleInSection(_ section: Int) -> String
    func sectionFooterButtonTitleInSection(_ section: Int) -> String
}
