//
//  FirstViewController.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/17.
//

import Foundation
import UIKit

final class FirstViewController: UIViewController {

    let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "First"
        label.font = UIFont.boldSystemFont(ofSize: 70.0)
        label.textColor = UIColor.white
        return label
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .blue

        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLabel)
        NSLayoutConstraint.activate([
            centerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
