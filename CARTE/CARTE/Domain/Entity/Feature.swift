//
//  Feature.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/04.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import KarteTracker

struct Feature {
    var title: String
    var date: Date?
    var image: ImageSource?
    var url: URL?
    
    var variable: KarteVariable
}
