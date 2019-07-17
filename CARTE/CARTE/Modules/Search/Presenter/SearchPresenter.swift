//
//  SearchSearchPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

class SearchPresenter: SearchViewOutput, SearchInteractorOutput {

    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!

    func viewIsReady() {

    }
}
