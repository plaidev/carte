//
//  ItemBasicCell.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/05.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class ItemBasicCell: UITableViewCell {
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Item) {
        brandLabel.text = item.brand
        nameLabel.text = item.name
        priceLabel.text = item.price.string
    }

}
