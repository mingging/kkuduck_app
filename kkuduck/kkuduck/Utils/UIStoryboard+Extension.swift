//
//  UIStoryboard+Extension.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/25.
//

import UIKit

extension UIStoryboard {

    public static let main = UIStoryboard(name: "Main", bundle: nil)

    public func instantiateViewController<T>(withIdentifier identifier: T.Type) -> T where T: UIViewController {
         let className = String(describing: identifier)
         guard let vc =  self.instantiateViewController(withIdentifier: className) as? T else {
             fatalError("Cannot find controller with identifier \(className)")
         }
         return vc
     }

}
