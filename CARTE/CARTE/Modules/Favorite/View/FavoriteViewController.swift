//
//  FavoriteFavoriteViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, FavoriteViewInput {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
    var output: FavoriteViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: FavoriteViewInput
    func setupInitialState() {
        collectionView.register(R.nib.itemCell)
    }
    
    func refresh() {
        emptyView.isHidden = output.numberOfItems > 0
        collectionView.reloadData()
    }
    
    @IBAction func tapCartButton(_ sender: UIBarButtonItem) {
        output.tapCartButton()
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.itemCell, for: indexPath) else {
            fatalError()
        }
        
        cell.configureCell(item: output.itemAt(indexPath.item))
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.tapItemAt(indexPath.item)
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    
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
