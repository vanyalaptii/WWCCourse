//
//  HomeDetailsViewController.swift
//  UINavigation
//
//  Created by Ваня Лаптий on 27.05.2023.
//

import UIKit

class HomeDetailsViewController: UIViewController {
    
    let homeButton = UIButton()
    let detailsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHomeButton()
        setupDetailsButton()
    }
}

extension HomeDetailsViewController {
    func setupHomeButton() {
        view.addSubview(homeButton)
        homeButton.setTitle("Home", for: .normal)
        homeButton.setTitleColor(.black, for: .normal)
        homeButton.layer.cornerRadius = 15
        homeButton.addTarget(self, action: #selector(homeButtonDidPressed), for: .touchUpInside)
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        
        homeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        homeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
    }
    
    func setupDetailsButton() {
        view.addSubview(detailsButton)
        detailsButton.setTitle("Detail", for: .normal)
        detailsButton.setTitleColor(.black, for: .normal)
        detailsButton.layer.cornerRadius = 15
        detailsButton.addTarget(self, action: #selector(detailsButtonDidPressed), for: .touchUpInside)
        
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        
        detailsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        detailsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: +50).isActive = true
    }
    
    @objc private func homeButtonDidPressed() {
        let  controller =  self.navigationController?.viewControllers.filter({$0 is TabBarViewController}).first
        self.navigationController?.popToViewController(controller!, animated: true)
    }
    
    @objc private func detailsButtonDidPressed() {
        let controller = DetailsViewController()
        navigationController?.present(controller, animated: true)
    }
}
