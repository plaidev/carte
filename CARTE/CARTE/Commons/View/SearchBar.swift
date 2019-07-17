//
//  SearchBar.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/05.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {
    var submit: ((_ query: String) -> Void)?

    var textField: UITextField? {
        return self.value(forKey: "searchField") as? UITextField
    }
    
    init(_ submit: @escaping ((_ query: String) -> Void)) {
        self.init()
        self.submit = submit
    }
    
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
        self.delegate = self
        self.placeholder = "なにをお探しですか？"
        
        guard let textField = self.textField else {
            return
        }

        textField.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 0.1)
        textField.inputAccessoryView = {
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancelButton(_:)))
            ]
            return toolbar
        }()
    }
    
    @objc private func tapCancelButton(_ sender: UIBarButtonItem) {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension SearchBar: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.submit?(searchBar.text ?? "")
    }
}
