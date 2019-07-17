//
//  Item.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/04.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

struct Item {
    var id: ItemId
    var name: String
    var price: Price
    var brand: String
    var image: ItemImageSet
    var category: String?
}

struct ItemImageSet {
    var middle: ImageSource?
    var large: ImageSource?
}
