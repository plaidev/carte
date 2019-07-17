//
//  MyPageCell.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class MyPageCell: UITableViewCell {
    
    func configureCell(row: Row) {
        self.accessoryType = row.accessoryType
        self.selectionStyle = row.selectionStyle
    }
}
