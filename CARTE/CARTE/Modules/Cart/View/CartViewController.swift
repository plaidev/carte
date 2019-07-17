//
//  CartCartViewController.swift
//  CARTE
//
//  Created by tomoki.koga on 02/06/2019.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, CartViewInput {
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var freeShippingLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    var output: CartViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        emptyView.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }

    // MARK: CartViewInput
    func setupInitialState() {
        quantityLabel.text = "カートに入っているアイテム：\(output.numberOfPaymentItems)点"
        separator.backgroundColor = tableView.separatorColor
        priceLabel.text = output.price.string
        
        let balance = output.freeShippingBalance
        freeShippingLabel.isHidden = balance.value == 0
        freeShippingLabel.text = "あと\(balance.string)のお買い上げで送料無料"
        tableView.reloadData()
        
        tableView.isHidden = output.numberOfPaymentItems == 0
        emptyView.isHidden = output.numberOfPaymentItems > 0
    }
    
    func refreshPoint(_ point: Int) {
        pointLabel.text = "あなたの保有ポイント \(point)pt"
    }
    
    @IBAction func tapRegistrationButton(_ sender: UIButton) {
        output.tapRegistrationButton()
    }
    
    @IBAction func tapContinueShoppingButton(_ sender: UIButton) {
        output.tapContinueShoppingButton()
    }
}

extension CartViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfPaymentItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cartItemCell, for: indexPath) else {
            fatalError()
        }
        
        cell.configureCell(paymentItem: output.paymentItemAt(indexPath.row)) { [weak self] (paymentItem) in
            self?.output.removePaymentItem(paymentItem)
        }
        return cell
    }
}
