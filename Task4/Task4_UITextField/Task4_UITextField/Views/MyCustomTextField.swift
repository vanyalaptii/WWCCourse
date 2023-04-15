//
//  MyCustomTextFieldVIew.swift
//  Task4_UITextField
//
//  Created by Ваня Лаптий on 16.04.2023.
//

import UIKit

// Define a custom text field class that inherits from UITextField
class MyCustomTextField: UITextField {
    
    // Define a callback closure that takes a string parameter
    var textChangedCallback: ((String) -> Void)?
    var editingDidEndCallback: ((String) -> Void)?
    
    // Define a label to display the character count
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    // Override the text property's didSet observer
    override var text: String? {
        didSet {
            // Call the callback closure with the updated text value
            textChangedCallback?(text ?? "")
        }
    }
    
    // Initialize the custom text field
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCharacterCountLabel()
        // Add a target for editingChanged event
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCharacterCountLabel()
        // Add a target for editingChanged event
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    private func setupCharacterCountLabel() {
            // Add the character count label as a subview and configure constraints
            addSubview(characterCountLabel)
            characterCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
            characterCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        }
    
    // Helper method to handle the editingChanged event
    @objc private func textFieldDidChange() {
        // Call the callback closure with the updated text value
        textChangedCallback?(text ?? "")
        // Update the character count label with the current text length
        characterCountLabel.text = "\(text?.count ?? 0)"
    }
    // Helper method to handle the editingDidEnd event
    @objc private func textFieldDidEndEditing() {
        // Call the callback closure with the text value
        editingDidEndCallback?(text ?? "")
    }
}

