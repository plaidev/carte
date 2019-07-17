//
//  FavoriteFavoriteInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift
import KarteTracker

class FavoriteInteractor: FavoriteInteractorInput {

    weak var output: FavoriteInteractorOutput!

    private let favoriteRepository: FavoriteRepository
    private let itemRepository: ItemRepository
    
    init(favoriteRepository: FavoriteRepository, itemRepository: ItemRepository) {
        self.favoriteRepository = favoriteRepository
        self.itemRepository = itemRepository
    }
    
    func fetchFavoriteItems() {
        let itemRepository = self.itemRepository
        _ = favoriteRepository.fetchAll().flatMap { (itemIds) -> PrimitiveSequence<SingleTrait, [Item]> in
            itemRepository.fetchItems(itemIds: itemIds)
        }.subscribe { [weak self] (event) in
            self?.output.fetchedFavoriteItems(event)
        }
    }
    
    func trackView() {
        KarteTracker.shared.view("favorite", title: "お気に入り", values: [
            "view_id": "favorite"
        ])
    }
}
