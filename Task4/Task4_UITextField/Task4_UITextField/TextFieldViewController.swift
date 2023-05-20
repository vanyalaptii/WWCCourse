//
//  ViewController.swift
//  Task4_UITextField
//
//  Created by Ваня Лаптий on 16.04.2023.
//

import UIKit

final class TextFieldViewController: UIViewController, UITextFieldDelegate {
    
    // Create an instance of the custom text fields
    let myTextField = MyCustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
    let secondTextField = UITextField(frame: CGRect(x: 0, y: 150, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        myTextFieldSetup()
        secondTextFieldSetup()
        minimumStringCountSizeLabelSetup()
    }
    
    func myTextFieldSetup() {
        // Set the text changed callback
        myTextField.textChangedCallback = { [weak self] newText in
            print("Text changed: \(newText)")
            // Perform any other actions or updates based on the changed text
        }
        // Set the editingDidEnd callback
        myTextField.editingDidEndCallback = { text in
            print("Editing did end and focus was changed. Text count: \(text.count)")
            // Perform any other actions or updates based on the text field losing focus
        }
        
        myTextField.editingDidBeginCallback = {
            print("Focus is on MyCustomTextField")
        }
        
        myTextField.backgroundColor = .systemGray
        myTextField.borderStyle = .roundedRect
        myTextField.center = view.center
        myTextField.textColor = .white
        myTextField.placeholder = "Type text"
//        myTextField.becomeFirstResponder()
        
        let clearTextFieldButton = UIButton(type: .system)
        clearTextFieldButton.setImage(.remove.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        clearTextFieldButton.addTarget(myTextField, action: #selector(MyCustomTextField.clearTextField), for: .touchUpInside)
        myTextField.addLeftControl(clearTextFieldButton)
        
        self.view.addSubview(myTextField)
    }
    
    func secondTextFieldSetup() {
        secondTextField.placeholder = "Focus here"
        secondTextField.center.x = view.center.x
        secondTextField.delegate = self
        
        self.view.addSubview(secondTextField)
    }
    
     func minimumStringCountSizeLabelSetup() {
         
         let minimumStringCountSizeLabel: UILabel = {
             let label = UILabel()
             label.text = "Minimum 2 digits required"
             label.translatesAutoresizingMaskIntoConstraints = false
             label.textAlignment = .center
             label.font = UIFont.systemFont(ofSize: 12)
             label.textColor = .red
             label.isHidden = true
             return label
         }()
         
        // Add the character count label as a subview and configure constraints
         self.view.addSubview(minimumStringCountSizeLabel)
        NSLayoutConstraint.activate([
            minimumStringCountSizeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -70),
            minimumStringCountSizeLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 30)
        ])
    }
    
}

extension MyCustomTextField {
    //In this method we can describe what should happend when the return button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return key is pressed")
        //This method is hiding keyboard
        textField.resignFirstResponder()
        return true
    }
}
