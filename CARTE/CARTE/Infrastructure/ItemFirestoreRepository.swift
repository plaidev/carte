//
//  ItemFirestoreRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/12.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RxSwift

class ItemFirestoreRepository: ItemRepository {
    private let collection: CollectionReference
    
    init() {
        self.collection = Firestore.firestore().collection("item")
    }
    
    func fetchAllItemIds() -> Single<[ItemId]> {
        return Single<[ItemId]>.create(subscribe: { (observer) -> Disposable in
            self.collection.getDocuments(completion: { (snapshot, error) in
                if let error = error {
                    observer(.error(error))
                }
                if let itemIds = snapshot?.documents.map({ ItemId(id: $0.documentID) }) {
                    observer(.success(itemIds))
                } else {
                    let error = NSError(domain: "io.karte.play", code: 404, userInfo: [
                        NSLocalizedDescriptionKey: "Item not found."
                    ])
                    observer(.error(error))
                }
            })
            return Disposables.create()
        })
    }
    
    func fetchAllItems() -> Single<[Item]> {
        return Single<[Item]>.create(subscribe: { (observer) -> Disposable in
            self.collection.getDocuments(completion: { (snapshot, error) in
                if let error = error {
                    observer(.error(error))
                }
                if let items = snapshot?.documents.map({ self.toItem(id: $0.documentID, data: $0.data()) }) {
                    observer(.success(items))
                } else {
                    let error = NSError(domain: "io.karte.play", code: 404, userInfo: [
                        NSLocalizedDescriptionKey: "Item not found."
                    ])
                    observer(.error(error))
                }
            })
            return Disposables.create()
        })
    }
    
    func fetchItems(itemIds: [ItemId]) -> Single<[Item]> {
        let observables = itemIds.map({ self.fetchItem(itemId: $0).asObservable() })
        return Observable.combineLatest(observables).asSingle()
    }
    
    func fetchItem(itemId: ItemId) -> Single<Item> {
        return Single<Item>.create(subscribe: { (observer) -> Disposable in
            self.collection.document(itemId.id).getDocument { (snapshot, error) in
                if let error = error {
                    observer(.error(error))
                }
                if let documentID = snapshot?.documentID, let data = snapshot?.data() {
                    let item = self.toItem(id: documentID, data: data)
                    observer(.success(item))
                } else {
                    let error = NSError(domain: "io.karte.play", code: 404, userInfo: [
                        NSLocalizedDescriptionKey: "Item not found."
                    ])
                    observer(.error(error))
                }
            }
            return Disposables.create()
        })
    }
    
    private func toItem(id: String, data: [String: Any]) -> Item {
        let name = data["name"] as? String
        let price = data["price"] as? Int
        let image = data["image"] as? [String : Any]
        let brand = data["brand"] as? String
        let middleImage = image?["middle"] as? String
        let largeImage = image?["large"] as? String
        let category = data["category"] as? String
        
        let item = Item(
            id: ItemId(id: id),
            name: name ?? "",
            price: Price(value: price ?? 0),
            brand: brand ?? "",
            image: ItemImageSet(middle: middleImage, large: largeImage),
            category: category
        )
        return item
    }
}
