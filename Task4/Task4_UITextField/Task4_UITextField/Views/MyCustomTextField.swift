//
//  MyCustomTextFieldVIew.swift
//  Task4_UITextField
//
//  Created by Ваня Лаптий on 16.04.2023.
//

import UIKit

// Define a custom text field class that inherits from UITextField
class MyCustomTextField: UITextField, UITextFieldDelegate {
    // Define a callback closure that takes a string parameter
    var textChangedCallback: ((String) -> Void)?
    var editingDidEndCallback: ((String) -> Void)?
    var editingDidBeginCallback: (() -> Void)?
    
    let underlineLayer = CALayer()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 10)))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.textColor = .white
        label.isHidden = false
        return label
    }()
    
    // Override the text property's didSet observer
    override var text: String? {
        didSet {
            // Call the callback closure with the updated text value
            textChangedCallback?(text ?? "")
        }
    }
    
    // Define a label to display the character count
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.isHidden = false
        return label
    }()
    
    
    // Initialize the custom text field
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        // Add a target for editingChanged event
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //MARK: change frames to autolayout
        // Adjust the placeholder label position and size
        if !isEditing && text?.isEmpty ?? true {
            let x = placeholderLabel.frame.origin.x
            let y = placeholderLabel.frame.origin.y
            let width = placeholderLabel.intrinsicContentSize.width
            let height = placeholderLabel.intrinsicContentSize.height
            placeholderLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            placeholderLabel.frame = CGRect(x: 30, y: 4, width: placeholderLabel.intrinsicContentSize.width, height: placeholderLabel.intrinsicContentSize.height)
        }
    }
    
    private func setupSubviews() {
        // Add the character count label as a subview and configure constraints
        addSubview(placeholderLabel)
        addSubview(characterCountLabel)
        NSLayoutConstraint.activate([
            characterCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            characterCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        // Set up the underline layer
        underlineLayer.backgroundColor = UIColor.gray.cgColor
        underlineLayer.frame = CGRect(x: 5, y: frame.height, width: frame.width - 10, height: 1)
        layer.addSublayer(underlineLayer)
                
    }
    
    func addLeftControl(_ control: UIControl) {
        leftView = control
        leftViewMode = .whileEditing
    }
    
    // Helper method to handle the editingChanged event
    @objc private func textFieldDidChange() {
        // Call the callback closure with the updated text value
        textChangedCallback?(text ?? "")
        // Update the character count label with the current text length
        characterCountLabel.text = "\(text?.count ?? 0)"
       
        if text != "" {
            placeholderLabel.text = placeholder
        } else {
            placeholderLabel.text = ""
        }
        
        if (text ?? "").count < 8 {
            characterCountLabel.textColor = .red
            characterCountLabel.text = "Min 8 symbols required"
        } else {
            characterCountLabel.textColor = .white
        }
        
        updateUnderline()
    }
    
    // Helper method to handle the editingDidEnd event
    @objc private func textFieldDidEndEditing() {
        // Call the callback closure with the text value
        editingDidEndCallback?(text ?? "")
    }
    
    @objc private func textFieldDidBeginEditing() {
        editingDidBeginCallback?()
    }
    
    @objc func clearTextField() {
        text = ""
        characterCountLabel.text = "\(text?.count ?? 0)"
        placeholderLabel.text = ""
        characterCountLabel.textColor = .red
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
        setNeedsLayout()
    }
    
    private func updateUnderline() {
        let color = isEditing ? UIColor.cyan.cgColor : UIColor.gray.cgColor
        let width: CGFloat = isEditing ? 2 : 1
        underlineLayer.backgroundColor = color
        underlineLayer.frame = CGRect(x: 3, y: frame.height - width, width: frame.width - 6, height: width)
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateUnderline()
        return result
    }
    
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateUnderline()
        return result
    }
}

