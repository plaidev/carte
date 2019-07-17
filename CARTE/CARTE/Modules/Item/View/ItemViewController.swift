//
//  ItemItemViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, ItemViewInput {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var output: ItemViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: ItemViewInput
    func setupInitialState() {
        imageView.setImageSource(output.item.image.large)
        separator.backgroundColor = tableView.separatorColor
        favoriteButton.isEnabled = false
        
        configureContentOffset()
        tableView.reloadData()
    }
    
    func configureFavoriteButton(isFavorite: Bool) {
        favoriteButton.isEnabled = true
        favoriteButton.isSelected = isFavorite
    }
    
    @IBAction func tapCartButton(_ sender: UIBarButtonItem) {
        output.tapCartButton()
    }
    
    @IBAction func tapAddCartButton(_ sender: UIButton) {
        output.tapAddCartButton()
    }
    
    @IBAction func tapFavoriteButton(_ sender: UIButton) {
        output.tapFavoriteButton(isFavorite: sender.isSelected)
        sender.isEnabled = false
    }
}

extension ItemViewController {
    
    private func configureContentOffset() {
        let height = UIScreen.main.bounds.width * 27 / 23
        tableView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -height)
    }
    
    private func itemBasicCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.itemBasicCell, for: indexPath) else {
            fatalError()
        }
        
        cell.configureCell(item: output.item)
        return cell
    }
    
    private func itemDescriptionCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.itemDescriptionCell, for: indexPath) else {
            fatalError()
        }
        
        cell.configureCell(item: output.item)
        return cell
    }
    
    private func itemSizeCellAt(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.itemSizeCell, for: indexPath) else {
            fatalError()
        }
        
        cell.configureCell(item: output.item)
        return cell
    }
}

extension ItemViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch output.row(index: indexPath.row) {
        case .basic:
            return itemBasicCellAt(indexPath)
        case .description:
            return itemDescriptionCellAt(indexPath)
        case .size:
            return itemSizeCellAt(indexPath)
        }
    }
}
