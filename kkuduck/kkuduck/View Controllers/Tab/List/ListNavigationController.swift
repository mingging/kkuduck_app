//
//  ListNavigationController.swift
//  kkuduck
//
//  Created by heyji on 2021/11/30.
//

import UIKit

final class ListNavigationController: UINavigationController {

    private enum Font {
        static let navigaionBar = UIFont(name: "GmarketSansMedium", size: 16)
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
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.tintColor = .primary
    }

}
