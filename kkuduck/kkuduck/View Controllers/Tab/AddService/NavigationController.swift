//
//  NavigationController.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/23.
//

import UIKit

final class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        let navigationBarAppearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "GmarketSansBold", size: 18)!]
        navigationBarAppearance.titleTextAttributes = attributes
        navigationBarAppearance.buttonAppearance.normal.titleTextAttributes = attributes
        navigationBarAppearance.doneButtonAppearance.normal.titleTextAttributes = attributes
        navigationBarAppearance.backgroundColor = .primary
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.shadowImage = UIImage()
    }

}
