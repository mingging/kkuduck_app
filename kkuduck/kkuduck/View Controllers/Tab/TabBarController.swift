//
//  CustomTabBarController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/27.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        tabBar.backgroundColor = .primary
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = .white
    }

}
