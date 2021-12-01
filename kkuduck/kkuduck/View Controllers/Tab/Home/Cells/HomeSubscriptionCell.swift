//
//  HomeSubscriptionCell.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/16.
//

import UIKit

final class HomeSubscriptionCell: UICollectionViewCell {

    private enum Metric {
        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 1
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity: Float = 0.2
    }

    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cycleLabel: UILabel!
    @IBOutlet weak var nextDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbnailContainerView: UIView!

    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        contentView.layer.cornerRadius = Metric.cornerRadius
        contentView.layer.borderWidth = Metric.borderWidth
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = Metric.shadowRadius
        layer.shadowOpacity = Metric.shadowOpacity
        layer.masksToBounds = false

        thumbnailContainerView.layer.cornerRadius = (thumbnailContainerView.frame.height) / 2
    }

    func configure(with subscription: Subscription) {
        nameLabel.text = subscription.serviceName
        cycleLabel.text = subscription.cycle.rawValue
        priceLabel.text = "\(subscription.planPrice) 원"
        let nextDate = DateHelper.nextSubscriptionDate(from: subscription.startDate, matching: subscription.cycle)!
        nextDateLabel.text = DateHelper.string(from: nextDate)
        ImageCache.load(urlString: subscription.imageUrl) { image in
            self.imageView.image = image ?? .logo
        }
    }

}
