//
//  SearchResultSearchResultPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

class SearchResultPresenter: SearchResultModuleInput {

    weak var view: SearchResultViewInput!
    var interactor: SearchResultInteractorInput!
    var router: SearchResultRouterInput!

    private var _query: String
    private var items = [Item]()
    
    init(query: String) {
        self._query = query
    }
    
    func viewIsReady() {
        view.setupInitialState()
        interactor.search(query: query)
    }
    
    func viewDidAppear() {
        interactor.trackView(query: query)
    }
}

extension SearchResultPresenter: SearchResultViewOutput {
    
    var query: String {
        return _query
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return items.count
    }
    
    func itemAt(_ index: Int) -> Item {
        return items[index]
    }
    
    func tapItemAt(_ index: Int) {
        router.showItem(item: items[index])
    }
    
    func tapCartButton() {
        router.showCart()
    }
}

extension SearchResultPresenter: SearchResultInteractorOutput {
    
    func searched(_ items: [Item]) {
        self.items = items
        view.refresh()
    }
}
