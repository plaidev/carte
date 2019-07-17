//
//  MyPageMyPageViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, MyPageViewInput {
    @IBOutlet weak var tableView: UITableView!
    
    var output: MyPageViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewIsReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: MyPageViewInput
    func setupInitialState() {
        tableView.reloadData()
    }
}

extension MyPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = output.rowAt(indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath) as? MyPageCell else {
            fatalError()
        }
        
        cell.configureCell(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = output.sectionAt(section)
        return section.title
    }
}

extension MyPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.rowAt(indexPath).didSelect?(tableView, indexPath)
    }
}
