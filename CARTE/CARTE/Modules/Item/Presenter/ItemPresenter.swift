//
//  ItemItemPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import RxSwift

class ItemPresenter: ItemModuleInput {

    enum Row: Int {
        case basic
        case description
        case size
    }
    
    weak var view: ItemViewInput!
    var interactor: ItemInteractorInput!
    var router: ItemRouterInput!

    private let _item: Item
    
    init(item: Item) {
        self._item = item
    }
    
    func viewIsReady() {
        interactor.isFavorite(item: item)
        view.setupInitialState()
    }
    
    func viewDidAppear() {
        interactor.trackView(item: item)
    }
}

extension ItemPresenter: ItemViewOutput {
    
    var item: Item {
        return _item
    }
    
    func tapCartButton() {
        router.showCart()
    }
    
    func tapAddCartButton() {
        interactor.addCart(item: item)
    }
    
    func tapFavoriteButton(isFavorite: Bool) {
        if isFavorite {
            interactor.removeFavorite(item: item)
        } else {
            interactor.addFavorite(item: item)
        }
    }
    
    func row(index: Int) -> ItemPresenter.Row {
        guard let row = Row(rawValue: index) else { fatalError() }
        return row
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 3
    }
}

extension ItemPresenter: ItemInteractorOutput {
    
    func addedCart(_ event: SingleEvent<Void>) {
        switch event {
        case .success(_):
            interactor.trackCartEvent()
            router.showCart()
        case .error(_):
            break
        }
    }
    
    func addedFavorite(_ event: SingleEvent<Void>) {
        switch event {
        case .success(_):
            interactor.trackFavoriteEvent()
            self.view.configureFavoriteButton(isFavorite: true)
        case .error(_):
            break
        }
    }
    
    func removedFavorite(_ event: SingleEvent<Void>) {
        switch event {
        case .success(_):
            interactor.trackFavoriteEvent()
            self.view.configureFavoriteButton(isFavorite: false)
        case .error(_):
            break
        }
    }
    
    func containedFavorite(_ event: SingleEvent<Bool>) {
        switch event {
        case .success(let isFavorite):
            self.view.configureFavoriteButton(isFavorite: isFavorite)
        case .error(_):
            break
        }
    }
}
