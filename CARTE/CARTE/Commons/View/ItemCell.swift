//
//  ItemCell.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/03.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(item: Item, rank: Int? = nil) {
        imageView.setImageSource(item.image.middle)
        priceLabel.text = item.price.string
        configureRankLabel(rank: rank)
    }
    
    private func configureRankLabel(rank: Int?) {
        guard let rank = rank else {
            rankLabel.isHidden = true
            return
        }
        
        rankLabel.text = String(rank)
        rankLabel.textColor = .white
        switch rank {
        case 1:
            rankLabel.backgroundColor = R.color.rank_1()
        case 2:
            rankLabel.backgroundColor = R.color.rank_2()
        case 3:
            rankLabel.backgroundColor = R.color.rank_3()
        default:
            rankLabel.backgroundColor = R.color.rank_other()
            rankLabel.textColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        }
    }
}
