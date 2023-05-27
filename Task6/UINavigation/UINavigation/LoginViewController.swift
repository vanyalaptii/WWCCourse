//
//  ViewController.swift
//  UINavigation
//
//  Created by Ваня Лаптий on 27.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLoginButton()
    }
}

extension LoginViewController {
    func setupLoginButton() {
        view.addSubview(button)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(loginDidPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc private func loginDidPressed() {
        let controller = TabBarViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
