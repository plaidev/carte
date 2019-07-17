//
//  FeatureCell.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/03.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class FeatureCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(feature: Feature) {
        feature.image?.reflectToImageView(imageView)
        titleLabel.text = feature.title
        dateLabel.text = feature.date.map { (date) -> String in
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy.MM.dd", options: 0, locale: Locale(identifier: "ja_JP"))
            return formatter.string(from: date)
        } ?? "-"
    }
}
