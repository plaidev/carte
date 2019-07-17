//
//  SectionButtonReusableView.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/04.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SectionButtonReusableView: UICollectionReusableView {
    @IBOutlet weak var button: UIButton!
    
    private var query: String?
    private var handler: ((_ query: String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.layer.cornerRadius = 4
        button.layer.borderColor = R.color.button_secondary()?.cgColor
        button.layer.borderWidth = 1
    }
    
    func configureTitle(_ title: String, query: String, handler: ((_ query: String) -> Void)?) {
        button.setTitle(title, for: .normal)
        
        self.query = query
        self.handler = handler
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        self.handler?(query ?? "")
    }
}
