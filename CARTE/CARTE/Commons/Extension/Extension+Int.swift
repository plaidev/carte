//
//  Extension+Int.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/05.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

extension Int: ExtensionCompatible {}

extension Extension where Base == Int {
    
    var comma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        
        guard let digits = formatter.string(from: NSNumber(value: base as Int)) else {
            return String(base)
        }
        
        return digits
    }
}
