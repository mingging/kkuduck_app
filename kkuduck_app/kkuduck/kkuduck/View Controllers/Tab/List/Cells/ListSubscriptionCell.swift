//
//  ListSubscriptionCell.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/25.
//

import UIKit

final class ListSubscriptionCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet var imageCellView: UIView!
    @IBOutlet weak var subscriptionImageView: UIImageView!
    @IBOutlet weak var subscriptionNameLabel: UILabel!
//    @IBOutlet weak var stratDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet var endCellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        cellView.layer.cornerRadius = 15
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.2
        cellView.layer.shadowRadius = 10
        cellView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cellView.layer.masksToBounds = false
        cellView.layer.shadowPath = UIBezierPath(roundedRect: cellView.bounds, cornerRadius: cellView.layer.cornerRadius).cgPath

        endCellView.layer.cornerRadius = 15

    }

}
