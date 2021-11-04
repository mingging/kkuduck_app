//
//  CustomTabBarController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/27.
//

import UIKit

class CustomTabBarController: UITabBarController {

    var circle: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor(hex: "#FDAC53ff")
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = UIColor(hex: "#ffffffff")
        tabBar.shadowImage = UIImage()
    }

}
