//
//  TabBarViewController.swift
//  UINavigation
//
//  Created by Ваня Лаптий on 27.05.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    let firstViewController = FirstViewController()
    let logOutViewController = LogOutViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupFirstViewController()
        setupLogOutViewController()
        self.setViewControllers([firstViewController, logOutViewController], animated: true)
    }
    
    private func setupFirstViewController() {
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: "first", image: .init(systemName: "arrow.up"), tag: 0)
        firstViewController.tabBarItem = tabBarItem
    }
    
    private func setupLogOutViewController() {
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: "second", image: .init(systemName: "arrow.turn.down.right"), tag: 1)
        logOutViewController.tabBarItem = tabBarItem
    }
}
