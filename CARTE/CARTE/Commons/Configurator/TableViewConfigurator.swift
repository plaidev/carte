//
//  TableViewConfigurator.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/06.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class Section {
    var title = ""
    var rows = [Row]()
    
    init(_ closure: (_ section: Section) -> Void) {
        closure(self)
    }
}

class Row {
    var reuseIdentifier = ""
    var title = ""
    var subtitle: String?
    var accessoryType: UITableViewCell.AccessoryType = .none
    var selectionStyle: UITableViewCell.SelectionStyle = .default
    
    var didSelect: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    var didDeselect: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    
    init(_ closure: (_ row: Row) -> Void) {
        closure(self)
    }
}
