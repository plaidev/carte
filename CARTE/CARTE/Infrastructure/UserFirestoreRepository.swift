//
//  UserFirestoreRepository.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/13.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RxSwift

class UserFirestoreRepository: UserRepository {
    private let collection: CollectionReference
    
    init() {
        self.collection = Firestore.firestore().collection("user")
    }
    
    func retrieveUser(userId: UserId) -> Single<User> {
        return Single<User>.create(subscribe: { (observer) -> Disposable in
            let query = self.collection.document(userId.id)
            query.getDocument(completion: { (snapshot, error) in
                if let error = error {
                    observer(.error(error))
                }
                if let data = snapshot?.data() {
                    let id = data["id"] as? String
                    let anonymous = data["anonymous"] as? Bool
                    let subscription = data["subscription"] as? Bool
                    let shopNotification = data["shop_notification"] as? Bool
                    let brandNotification = data["brand_notification"] as? Bool
                    let birthDate = data["birth_date"] as? Timestamp
                    let point = data["point"] as? Int
                    
                    let user = User(
                        id: UserId(id: id ?? ""),
                        anonymous: anonymous ?? true,
                        subscription: subscription ?? true,
                        shopNotification: shopNotification ?? true,
                        brandNotification: brandNotification ?? true,
                        birthDate: birthDate?.dateValue(),
                        point: point ?? 0
                    )
                    observer(.success(user))
                }
            })
            
            return Disposables.create()
        })
    }
    
    func updateUser(user: User) -> Single<Void> {
        return Single<Void>.create(subscribe: { (observer) -> Disposable in
            let birthDate = user.birthDate.map({ Timestamp(date: $0) })
            self.collection.document(user.id.id).setData([
                "id": user.id.id,
                "anonymous": user.anonymous,
                "subscription": user.subscription,
                "shop_notification": user.shopNotification,
                "brand_notification": user.brandNotification,
                "birth_date": birthDate ?? FieldValue.delete(),
                "point": user.point
            ], merge: true, completion: { (error) in
                if let error = error {
                    observer(.error(error))
                } else {
                    observer(.success(Void()))
                }
            })
            return Disposables.create()
        })
    }
}
