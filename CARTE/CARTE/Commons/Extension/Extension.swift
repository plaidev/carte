//
//  Extension.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/05.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import Foundation

struct Extension<Base> {
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

protocol ExtensionCompatible {
    associatedtype Compatible
    static var ext: Extension<Compatible>.Type { get }
    var ext: Extension<Compatible> { get }
}

extension ExtensionCompatible {
    
    static var ext: Extension<Self>.Type {
        return Extension<Self>.self
    }
    
    var ext: Extension<Self> {
        return Extension(self)
    }
}
