//
//  HomeHomeViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: HomeViewOutput!
    
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

    // MARK: HomeViewInput
    func setupInitialState() {
        collectionView.register(R.nib.featureCell)
        collectionView.register(R.nib.itemCell)
        collectionView.register(R.nib.featureReusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(R.nib.sectionTitleReusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(R.nib.sectionButtonReusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "UICollectionReusableView"
        )
    }
    
    func refresh() {
        collectionView.reloadData()
    }
    
    @IBAction func tapCartButton(_ sender: UIBarButtonItem) {
        output.tapCartButton()
    }
}

extension HomeViewController {
    
    private func configureSearchBar() {
        navigationItem.titleView = SearchBar { [weak self] (query) in
            self?.output.search(query: query)
        }
    }
    
    private func featureCellAt(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.featureCell, for: indexPath) else {
            fatalError()
        }
        cell.configureCell(feature: output.featureAt(indexPath.item))
        return cell
    }
    
    private func newItemCellAt(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.itemCell, for: indexPath) else {
            fatalError()
        }
        cell.configureCell(item: output.newItemAt(indexPath.item))
        return cell
    }
    
    private func rankingItemCellAt(_ indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.itemCell, for: indexPath) else {
            fatalError()
        }
        cell.configureCell(item: output.rankingItemAt(indexPath.item), rank: output.rank(indexPath.item))
        return cell
    }
    
    private func featureReusableViewAt(_ indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: R.nib.featureReusableView, for: indexPath) else {
            fatalError()
        }
        return view
    }
    
    private func sectionTitleReusableViewAt(_ indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: R.nib.sectionTitleReusableView, for: indexPath) else {
            fatalError()
        }
        
        let section = output.section(indexPath.section)
        switch section {
        case .feature:
            break
        case .new, .ranking:
            view.configureTitle(output.sectionHeaderTitleInSection(section.index))
        }
        return view
    }
    
    private func sectionButtonReusableViewAt(_ indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: R.nib.sectionButtonReusableView, for: indexPath) else {
            fatalError()
        }
        
        let section = output.section(indexPath.section)
        switch section {
        case .feature:
            break
        case .new, .ranking:
            view.configureTitle(output.sectionFooterButtonTitleInSection(section.index), query: section.name) { [weak self] (query: String) in
                self?.output.search(query: query)
            }
        }
        return view
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        switch output.section(indexPath.section) {
        case .feature:
            cell = featureCellAt(indexPath)
        case .new:
            cell = newItemCellAt(indexPath)
        case .ranking:
            cell = rankingItemCellAt(indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view: UICollectionReusableView
        switch (kind, output.section(indexPath.section)) {
        case (UICollectionView.elementKindSectionHeader, .feature):
            view = featureReusableViewAt(indexPath, kind: kind)
        case (UICollectionView.elementKindSectionFooter, .feature):
            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionReusableView", for: indexPath)
        case (UICollectionView.elementKindSectionHeader, .new):
            view = sectionTitleReusableViewAt(indexPath, kind: kind)
        case (UICollectionView.elementKindSectionFooter, .new):
            view = sectionButtonReusableViewAt(indexPath, kind: kind)
        case (UICollectionView.elementKindSectionHeader, .ranking):
            view = sectionTitleReusableViewAt(indexPath, kind: kind)
        case (UICollectionView.elementKindSectionFooter, .ranking):
            view = sectionButtonReusableViewAt(indexPath, kind: kind)
        default:
            view = UICollectionReusableView()
        }
        return view
    }
}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch output.section(indexPath.section) {
        case .feature:
            output.tapFeatureAt(indexPath.item)
        case .new:
            output.tapNewItemAt(indexPath.item)
        case .ranking:
            output.tapRankingItemAt(indexPath.item)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
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
        
        switch output.section(indexPath.section) {
        case .feature:
            return CGSize(width: calculateItemWidth(2), height: 160)
        case .new, .ranking:
            return CGSize(width: calculateItemWidth(3), height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch output.section(section) {
        case .feature:
            return CGSize(width: collectionView.bounds.width, height: 280)
        case .new, .ranking:
            return CGSize(width: collectionView.bounds.width, height: 34)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch output.section(section) {
        case .feature:
            return CGSize(width: collectionView.bounds.width, height: 24)
        case .new, .ranking:
            return CGSize(width: collectionView.bounds.width, height: 74)
        }
    }
}
