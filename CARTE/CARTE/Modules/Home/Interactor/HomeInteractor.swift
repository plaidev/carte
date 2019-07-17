//
//  HomeHomeInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAnalytics
import KarteTracker

class HomeInteractor: HomeInteractorInput {
    weak var output: HomeInteractorOutput!

    private let featureRepository: FeatureRepository
    private let itemRepository: ItemRepository
    private let newItemRepository: NewItemRepository
    private let rankingRepository: RankingRepository
    
    init(featureRepository: FeatureRepository, itemRepository: ItemRepository, newItemRepository: NewItemRepository, rankingRepository: RankingRepository) {
        self.featureRepository = featureRepository
        self.itemRepository = itemRepository
        self.newItemRepository = newItemRepository
        self.rankingRepository = rankingRepository
    }
    
    func fetch() {
        let featureObservable = featureRepository.fetchAll().asObservable()
        let newItemObservable = newItemRepository.fetch().flatMap { (itemIds) -> PrimitiveSequence<SingleTrait, [Item]> in
            return self.itemRepository.fetchItems(itemIds: itemIds)
        }.asObservable()
        let rankingObservable = rankingRepository.fetch().flatMap { (itemIds) -> PrimitiveSequence<SingleTrait, [Item]> in
            return self.itemRepository.fetchItems(itemIds: itemIds)
        }.asObservable()
        
        _ = Observable.combineLatest(featureObservable, newItemObservable, rankingObservable).subscribe { [weak self] (event) in
            switch event {
            case .next(let (features, newItems, rankingItems)):
                self?.output.fetched(features: features, newItems: newItems, rankingItems: rankingItems)
            case .error(_):
                self?.output.fetched(features: [], newItems: [], rankingItems: [])
            case .completed:
                break
            }
        }
    }
    
    func fetchItem(itemId: ItemId) {
        _ = itemRepository.fetchItem(itemId: itemId).subscribe { [weak self] (event) in
            self?.output.fetchedItem(event)
        }
    }
    
    func trackView() {
        KarteTracker.shared.view("home", title: "ホーム", values: [
            "view_id": "home"
        ])
    }
    
    func trackFeaturesOpenEvent(features: [Feature]) {
        let variables = features.map { $0.variable }
        KarteVariables.track(variables: variables, eventName: KarteEventMessageOpen)
    }
    
    func trackFeatureClickEvent(feature: Feature) {
        KarteVariables.track(variables: [feature.variable], eventName: KarteEventMessageClick)
    }
    
    func trackSearchEvent(query: String) {
        KarteTracker.shared.track("search", values: [
            "keyword": query
        ])
    }
}
