//
//  AddSubscriptionNavigationController.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/23.
//

import UIKit

final class AddSubscriptionNavigationController: UINavigationController {

    private enum Font {
        static let navigaionBar = UIFont(name: "GmarketSansBold", size: 18)
    }

    // MARK: - View Life Cycle

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
        navigationBar.tintColor = .label
        navigationBar.shadowImage = UIImage()
    }

}
