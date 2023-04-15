//
//  ViewController.swift
//  Task4_UITextField
//
//  Created by Ваня Лаптий on 16.04.2023.
//

import UIKit

final class TextFieldViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        // Create an instance of the custom text field
        let myTextField = MyCustomTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        
        let secondTextField = UITextField(frame: CGRect(x: 0, y: 150, width: 100, height: 100))
        
        secondTextField.placeholder = "Focus here"
        secondTextField.center.x = view.center.x

        // Set the text changed callback
        myTextField.textChangedCallback = { newText in
            print("Text changed: \(newText)")
            // Perform any other actions or updates based on the changed text
        }
        // Set the editingDidEnd callback
        myTextField.editingDidEndCallback = { text in
            print("Editing did end and focus was changed. Text count: \(text.count)")
            // Perform any other actions or updates based on the text field losing focus
        }
        
        myTextField.backgroundColor = .systemGray
        myTextField.borderStyle = .roundedRect
        myTextField.center = view.center
        myTextField.textColor = .white
        myTextField.placeholder = "Type text"
        
        
        self.view.addSubview(myTextField)
        self.view.addSubview(secondTextField)
    }


}

