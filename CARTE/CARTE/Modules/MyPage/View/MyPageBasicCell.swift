//
//  MyPageBasicCell.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class MyPageBasicCell: MyPageCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func configureCell(row: Row) {
        super.configureCell(row: row)
        self.textLabel?.text = row.title
    }
}
