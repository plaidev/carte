//
//  SearchResultSearchResultViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 05/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, SearchResultViewInput {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: SearchResultViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        output.viewIsReady()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: SearchResultViewInput
    func setupInitialState() {
        collectionView.register(R.nib.itemCell)
    }
    
    func refresh() {
        collectionView.reloadData()
    }
    
    @IBAction func tapCartButton(_ sender: UIBarButtonItem) {
        output.tapCartButton()
    }
}

extension SearchResultViewController {
    
    private func configureSearchBar() {
        let searchBar = SearchBar()
        searchBar.text = output.query
        searchBar.textField?.isEnabled = false
        navigationItem.titleView = searchBar
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.itemCell, for: indexPath) else {
            fatalError()
        }
        
        cell.configureCell(item: output.itemAt(indexPath.item))
        return cell
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.tapItemAt(indexPath.item)
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        let width = collectionView.bounds.width
        let inset = layout.sectionInset.left + layout.sectionInset.right
        let spacing = layout.minimumInteritemSpacing
        
        let calculateItemWidth = { (num: Int) -> CGFloat in
            let space = inset + spacing * CGFloat(num - 1)
            let width = (width - space) / CGFloat(num)
            return width
        }
        
        return CGSize(width: calculateItemWidth(3), height: 180)
    }
}
