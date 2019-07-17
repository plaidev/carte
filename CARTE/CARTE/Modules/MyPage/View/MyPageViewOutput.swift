//
//  MyPageMyPageViewOutput.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

protocol MyPageViewOutput {
    func viewIsReady()
    func viewDidAppear()
    
    // TableViewDataSource
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func sectionAt(_ section: Int) -> Section
    func rowAt(_ indexPath: IndexPath) -> Row
}
