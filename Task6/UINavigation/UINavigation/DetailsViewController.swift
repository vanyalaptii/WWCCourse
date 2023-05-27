//
//  DetailsViewController.swift
//  UINavigation
//
//  Created by Ваня Лаптий on 27.05.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabelButton()
    }
}

extension DetailsViewController {
    func setupLabelButton() {
        view.addSubview(label)
        label.text = "Information"
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}
