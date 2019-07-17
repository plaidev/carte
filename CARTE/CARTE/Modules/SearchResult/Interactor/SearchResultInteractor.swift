//
//  SearchResultSearchResultInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import KarteTracker

class SearchResultInteractor: SearchResultInteractorInput {

    weak var output: SearchResultInteractorOutput!

    private let itemRepository: ItemRepository
    private let newItemRepository: NewItemRepository
    private let rankingRepository: RankingRepository
    
    init(itemRepository: ItemRepository, newItemRepository: NewItemRepository, rankingRepository: RankingRepository) {
        self.itemRepository = itemRepository
        self.newItemRepository = newItemRepository
        self.rankingRepository = rankingRepository
    }
    
    func search(query: String) {
        let single: Single<[ItemId]>
        if query == "新着アイテム" {
            single = newItemRepository.fetch()
        } else if query == "ランキング" {
            single = rankingRepository.fetch()
        } else {
            single = itemRepository.fetchAllItemIds()
        }
        
        let itemRepository = self.itemRepository
        _ = single.flatMap { (itemIds) -> PrimitiveSequence<SingleTrait, [Item]> in
            return itemRepository.fetchItems(itemIds: itemIds)
        }.subscribe { [weak self] (event) in
            switch event {
            case .success(let items):
                self?.output.searched(items)
            case .error(_):
                self?.output.searched([])
            }
        }
    }
    
    func trackView(query: String) {
        KarteTracker.shared.view("search_result", title: "検索結果", values: [
            "view_id": "search_result_\(query)"
        ])
    }
}
