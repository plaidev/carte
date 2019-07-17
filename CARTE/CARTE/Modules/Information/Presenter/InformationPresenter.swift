//
//  InformationInformationPresenter.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

class InformationPresenter: InformationModuleInput, InformationViewOutput, InformationInteractorOutput {

    weak var view: InformationViewInput!
    var interactor: InformationInteractorInput!
    var router: InformationRouterInput!

    func viewIsReady() {

    }
}
