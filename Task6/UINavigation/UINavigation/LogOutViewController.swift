//
//  SecondViewController.swift
//  UINavigation
//
//  Created by Ваня Лаптий on 27.05.2023.
//

import UIKit

class LogOutViewController: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "second"
        setupLogOutButton()
    }
}

extension LogOutViewController {
    func setupLogOutButton() {
        view.addSubview(button)
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(logOutButtonDidPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc private func logOutButtonDidPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}
