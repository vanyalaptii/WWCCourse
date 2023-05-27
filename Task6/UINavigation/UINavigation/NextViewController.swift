//
//  NextViewController.swift
//  UINavigation
//
//  Created by Ваня Лаптий on 27.05.2023.
//

import UIKit

class NextViewController: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNextButton()
    }
}

extension NextViewController {
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
        let controller = HomeDetailsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
