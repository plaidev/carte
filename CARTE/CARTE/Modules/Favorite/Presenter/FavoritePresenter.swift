//
//  FavoriteFavoritePresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift

class FavoritePresenter {

    weak var view: FavoriteViewInput!
    var interactor: FavoriteInteractorInput!
    var router: FavoriteRouterInput!

    private var items = [Item]()
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func viewWillAppear() {
        interactor.fetchFavoriteItems()
    }
    
    func viewDidAppear() {
        interactor.trackView()
    }
}

extension FavoritePresenter: FavoriteViewOutput {
    
    var numberOfItems: Int {
        return items.count
    }
    
    func itemAt(_ index: Int) -> Item {
        return items[index]
    }
    
    func tapItemAt(_ index: Int) {
        router.showItem(itemAt(index))
    }
    
    func tapCartButton() {
        router.showCart()
    }
}

extension FavoritePresenter: FavoriteInteractorOutput {
    
    func fetchedFavoriteItems(_ event: SingleEvent<[Item]>) {
        switch event {
        case .success(let items):
            self.items = items
            view.refresh()
        case .error(_):
            break
        }
    }
}
