//
//  HomeHomeInteractorInput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

protocol HomeInteractorInput {
    func fetch()
    func fetchItem(itemId: ItemId)
    func trackView()
    func trackFeaturesOpenEvent(features: [Feature])
    func trackFeatureClickEvent(feature: Feature)
    func trackSearchEvent(query: String)
}
