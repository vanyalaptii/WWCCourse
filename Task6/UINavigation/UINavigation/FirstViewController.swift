//
//  FirstViewController.swift
//  UINavigation
//
//  Created by Ваня Лаптий on 27.05.2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "first"
        setupNextButton()
    }
}

extension FirstViewController {
    func setupNextButton() {
        view.addSubview(button)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(nextButtonDidPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc private func nextButtonDidPressed() {
        let controller = NextViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
