//
//  FavoriteFirestoreRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RxSwift

class FavoriteFirestoreRepository: FavoriteRepository {
    private let collection: CollectionReference
    private let userId: UserId
    
    init(userId: UserId) {
        self.collection = Firestore.firestore().collection("favorite")
        self.userId = userId
    }
    
    func fetchAll() -> Single<[ItemId]> {
        return Single<[ItemId]>.create(subscribe: { (observer) -> Disposable in
            let query = self.collection.whereField("user_id", isEqualTo: self.userId.id)
            query.getDocuments { (snapshot, error) in
                if let error = error {
                    observer(.error(error))
                }
                if let snapshot = snapshot {
                    let itemIds = snapshot.documents.compactMap { (document) -> ItemId? in
                        let rawItemId = document.data()["item_id"] as? String
                        return rawItemId.map { ItemId(id: $0) }
                    }
                    observer(.success(itemIds))
                }
            }
            return Disposables.create()
        })
    }
    
    func add(itemId: ItemId) -> Single<Void> {
        return Single<Void>.create(subscribe: { (observer) -> Disposable in
            self.collection.addDocument(data: [
                "user_id": self.userId.id,
                "item_id": itemId.id
            ], completion: { (error) in
                if let error = error {
                    observer(.error(error))
                } else {
                    observer(.success(Void()))
                }
            })
            return Disposables.create()
        })
    }
    
    func remove(itemId: ItemId) -> Single<Void> {
        return Single<Void>.create(subscribe: { (observer) -> Disposable in
            let query = self.collection.whereField("user_id", isEqualTo: self.userId.id).whereField("item_id", isEqualTo: itemId.id)
            query.getDocuments(completion: { (snapshot, error) in
                if let error = error {
                    observer(.error(error))
                }
                
                if let documentId = snapshot?.documents.first?.documentID {
                    self.collection.document(documentId).delete(completion: { (error) in
                        if let error = error {
                            observer(.error(error))
                        } else {
                            observer(.success(Void()))
                        }
                    })
                }
            })
            return Disposables.create()
        })
    }
    
    func contains(itemId: ItemId) -> Single<Bool> {
        return Single<Bool>.create(subscribe: { (observer) -> Disposable in
            let query = self.collection.whereField("user_id", isEqualTo: self.userId.id).whereField("item_id", isEqualTo: itemId.id)
            query.getDocuments(completion: { (snapshot, error) in
                if let error = error {
                    observer(.error(error))
                }
                if let snapshot = snapshot {
                    observer(.success(!snapshot.isEmpty))
                }
            })
            
            return Disposables.create()
        })
    }
}
