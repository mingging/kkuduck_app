//
//  HomeSubscriptionCell.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/16.
//

import UIKit

final class HomeSubscriptionCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var cycleLabel: UILabel!
    @IBOutlet weak var nextDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbnailContainerView: UIView!

    override func awakeFromNib() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false

        thumbnailContainerView.layer.cornerRadius = (thumbnailContainerView.frame.height) / 2
    }

    func configure(with subscribe: Subscribe) {
        nameLabel.text = subscribe.subscription.name
        // TODO: image 수정
        let imageUrl = URL(string: subscribe.subscription.imageUrl)
        thumbnailImageView.image = UIImage(named: "logo.png")
        cycleLabel.text = subscribe.subscription.cycle
        priceLabel.text = "\(subscribe.subscription.price) 원"
        let startDate = subscribe.startDate
        let nextDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        nextDateLabel.text = formatter.string(from: nextDate!)
    }

}
