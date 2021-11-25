//
//  NavigationController.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/23.
//

import UIKit

final class NavigationController: UINavigationController {

    private enum Font {
        static let navigaionBar = UIFont(name: "GmarketSansBold", size: 18)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        let navigationBarAppearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.font: Font.navigaionBar!]
        navigationBarAppearance.titleTextAttributes = attributes
        navigationBarAppearance.buttonAppearance.normal.titleTextAttributes = attributes
        navigationBarAppearance.doneButtonAppearance.normal.titleTextAttributes = attributes
        navigationBarAppearance.backgroundColor = .primary
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.shadowImage = UIImage()
    }

}
