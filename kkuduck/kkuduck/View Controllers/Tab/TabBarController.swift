//
//  CustomTabBarController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/27.
//

import UIKit

final class TabBarController: UITabBarController {

    private enum Metric {
        static let shadowOffset = CGSize.zero
        static let shadowRadius: CGFloat = 2
        static let shadowOpacity: Float = 0.2
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        tabBar.backgroundColor = .primary
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .label
        tabBar.layer.shadowOffset = Metric.shadowOffset
        tabBar.layer.shadowRadius = Metric.shadowRadius
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = Metric.shadowOpacity
        tabBar.layer.shadowPath = UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: tabBar.layer.cornerRadius).cgPath
    }

}
