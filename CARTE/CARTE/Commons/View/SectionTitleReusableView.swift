//
//  SectionTitleReusableView.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/04.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SectionTitleReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }
}
