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
        tabBar.sendSubviewToBack(circle!)
        tabBar.backgroundColor = UIColor(hex: "#FDAC53ff")
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = UIColor(hex: "#ffffffff")
        tabBar.shadowImage = UIImage()
        
        
//        if let tbItems = tabBar.items {
//            tbItems[0].badgeColor =
//        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
