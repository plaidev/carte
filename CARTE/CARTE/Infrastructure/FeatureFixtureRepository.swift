//
//  FeatureFixtureRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import RxSwift
import KarteTracker

class FeatureFixtureRepository: FeatureRepository {
    
    func fetchAll() -> Single<[Feature]> {
        let features = [
            retrieveFeature(forKey: "feature_1", defaultValue: [
                "title": "旅のアイテム特集",
                "date": "2019.03.12",
                "image": R.image.img_feature_1()!,
                "url": "https://karte.io"
            ]),
            retrieveFeature(forKey: "feature_2", defaultValue: [
                "title": "新作デニム特集",
                "date": "2019.03.09",
                "image": R.image.img_feature_2()!,
                "url": "https://plaid.co.jp"
            ])
        ]
        
        return Single<[Feature]>.create(subscribe: { (observer) -> Disposable in
            observer(.success(features))
            return Disposables.create()
        })
    }
    
    private func retrieveFeature(forKey key: String, defaultValue: [AnyHashable: Any]) -> Feature {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy.MM.dd", options: 0, locale: Locale(identifier: "ja_JP"))
        
        let variable = KarteVariables.variable(forKey: key)
        let dict = variable.dictionary(defaultValue: defaultValue)
        
        let title = dict["title"] as? String
        let date = (dict["date"] as? String).flatMap({ formatter.date(from: $0) })
        let image = dict["image"] as? ImageSource
        let url = (dict["url"] as? String).flatMap({ URL(string: $0) })
        
        return Feature(
            title: title ?? "",
            date: date,
            image: image,
            url: url,
            variable: variable
        )
    }
}
