//
//  PrimaryButton.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/05.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.backgroundColor = R.color.button_primary()
        self.layer.cornerRadius = 4
    }
}
