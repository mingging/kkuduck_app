//
//  ReusableView.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/04.
//

import UIKit

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReusableView { }
extension UITableViewCell: ReusableView { }
