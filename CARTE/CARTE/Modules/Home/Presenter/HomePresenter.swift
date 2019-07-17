//
//  HomeHomePresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift

class HomePresenter {
    
    enum Section: Int {
        case feature
        case new
        case ranking
        
        var index: Int {
            return rawValue
        }
        
        var name: String {
            switch self {
            case .feature:
                return "特集"
            case .new:
                return "新着アイテム"
            case .ranking:
                return "ランキング"
            }
        }
    }

    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!

    private var content: HomeContent?
    private var features = [Feature]()
    private var newItems = [Item]()
    private var rankingItems = [Item]()
    
    init(content: HomeContent?) {
        self.content = content
    }
    
    func viewIsReady() {
        view.setupInitialState()
        interactor.fetch()
    }
    
    func viewDidAppear() {
        interactor.trackView()
        guard let content = content else {
            return
        }
        self.content = nil
        switch content {
        case .cart:
            router.showCart()
        case .search(let query):
            router.showSearchResult(query: query)
        case .item(let itemId):
            interactor.fetchItem(itemId: itemId)
        }
    }
}

extension HomePresenter: HomeViewOutput {
    
    func search(query: String) {
        interactor.trackSearchEvent(query: query)
        router.showSearchResult(query: query)
    }
    
    func section(_ section: Int) -> HomePresenter.Section {
        guard let section = Section(rawValue: section) else { fatalError() }
        return section
    }
    
    func numberOfSections() -> Int {
        return 3
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        switch self.section(section) {
        case .feature:
            return features.count
        case .new:
            return newItems.count
        case .ranking:
            return rankingItems.count
        }
    }
    
    func featureAt(_ index: Int) -> Feature {
        return features[index]
    }
    
    func newItemAt(_ index: Int) -> Item {
        return newItems[index]
    }
    
    func rankingItemAt(_ index: Int) -> Item {
        return rankingItems[index]
    }
    
    func rank(_ index: Int) -> Int {
        return index + 1
    }
    
    func sectionHeaderTitleInSection(_ section: Int) -> String {
        return self.section(section).name
    }
    
    func sectionFooterButtonTitleInSection(_ section: Int) -> String {
        return "\(self.section(section).name)をもっと見る"
    }
    
    func tapCartButton() {
        router.showCart()
    }
    
    func tapFeatureAt(_ index: Int) {
        interactor.trackFeatureClickEvent(feature: features[index])
        router.showFeature(features[index])
    }
    
    func tapNewItemAt(_ index: Int) {
        router.showItem(newItems[index])
    }
    
    func tapRankingItemAt(_ index: Int) {
        router.showItem(rankingItems[index])
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func fetched(features: [Feature], newItems: [Item], rankingItems: [Item]) {
        self.features = features
        self.newItems = newItems
        self.rankingItems = rankingItems
        interactor.trackFeaturesOpenEvent(features: features)
        view.refresh()
    }
    
    func fetchedItem(_ event: SingleEvent<Item>) {
        switch event {
        case .success(let item):
            router.showItem(item)
        case .error(_):
            break
        }
    }
}

extension HomePresenter {
}
