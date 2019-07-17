//
//  CartItemCell.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/05.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class CartItemCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var paymentItem: PaymentItem?
    var removePaymentItemHandler: ((_ paymentItem: PaymentItem) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(paymentItem: PaymentItem, removePaymentItemHandler: ((_ paymentItem: PaymentItem) -> Void)?) {
        let item = paymentItem.item
        itemImageView.setImageSource(item.image.middle)
        brandLabel.text = item.brand
        nameLabel.text = item.name
        colorLabel.text = "カラー：イエロー"
        sizeLabel.text = "サイズ：S"
        quantityLabel.text = "数量：\(paymentItem.quantity)"
        priceLabel.text = item.price.string
        
        self.paymentItem = paymentItem
        self.removePaymentItemHandler = removePaymentItemHandler
    }
    
    @IBAction func tapRemovePaymentItem(_ sender: UIButton) {
        if let paymentItem = paymentItem {
            removePaymentItemHandler?(paymentItem)
        }
    }
}
