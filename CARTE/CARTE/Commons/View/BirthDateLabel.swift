//
//  BirthDateLabel.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/06/14.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit


protocol BirthDateLabelDelegate: NSObjectProtocol {
    func birthDateLabel(_ label: BirthDateLabel, didSubmitBirthDate birthDate: Date)
}

class BirthDateLabel: UILabel {
    private let datePicker = { () -> UIDatePicker in
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(changeDateValue(_:)), for: .valueChanged)
        return datePicker
    }()
    
    weak var delegate: BirthDateLabelDelegate?
    var date: Date = Date() {
        didSet {
            datePicker.date = self.date
            reflectLabel(date: self.date)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    func configure() {
        isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(_:)))
        addGestureRecognizer(gestureRecognizer)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputView: UIView? {
        return datePicker
    }
    
    override var inputAccessoryView: UIView? {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.items = [
            UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(tapCancelButton(_:))),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "設定", style: .plain, target: self, action: #selector(tapSubmitButton(_:)))
        ]
        return toolbar
    }
    
    @objc private func tapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        becomeFirstResponder()
    }
    
    @objc private func tapCancelButton(_ sender: UIBarButtonItem) {
        resignFirstResponder()
        reflectLabel(date: date)
    }
    
    @objc private func tapSubmitButton(_ sender: UIBarButtonItem) {
        delegate?.birthDateLabel(self, didSubmitBirthDate: datePicker.date)
        reflectLabel(date: datePicker.date)
        resignFirstResponder()
    }
    
    @objc private func changeDateValue(_ sender: UIDatePicker) {
        reflectLabel(date: sender.date)
    }
    
    private func reflectLabel(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "yyyy.MM.dd",
            options: 0,
            locale: Locale(identifier: "ja_JP")
        )
        self.text = formatter.string(from: date)
    }
}

extension BirthDateLabel: UIKeyInput {
    var hasText: Bool {
        return false
    }
    
    func insertText(_ text: String) {
    }
    
    func deleteBackward() {
    }
}
