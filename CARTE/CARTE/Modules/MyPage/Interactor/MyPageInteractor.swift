//
//  MyPageMyPageInteractor.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import FirebaseAuth
import KarteTracker

class MyPageInteractor: MyPageInteractorInput {

    weak var output: MyPageInteractorOutput!
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            KarteTracker.shared.renewVisitorId()
            output.signOutSuccess()
        } catch let error {
            output.signOutFailure(error)
        }
    }

    func trackView() {
        KarteTracker.shared.view("mypage", title: "マイページ", values: [
            "view_id": "mypage"
        ])
    }
}
