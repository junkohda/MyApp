//
//  MainTabBarController.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/17.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }

    func setupTab() {
        let firstViewController = FirstViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "tab1", image: .none, tag: 0)

        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

        viewControllers = [firstViewController, secondViewController]
    }

}

