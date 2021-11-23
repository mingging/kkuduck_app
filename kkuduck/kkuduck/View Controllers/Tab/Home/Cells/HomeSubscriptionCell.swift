//
//  HomeSubscriptionCell.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/16.
//

import UIKit

final class HomeSubscriptionCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cycleLabel: UILabel!
    @IBOutlet weak var nextDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbnailContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false

        thumbnailContainerView.layer.cornerRadius = (thumbnailContainerView.frame.height) / 2
    }

    func configure(with subscription: Subscription) {
        nameLabel.text = subscription.name
        cycleLabel.text = subscription.cycle
        priceLabel.text = "\(subscription.price) 원"
        let nextDate = nextDate(from: subscription.startDate)!
        nextDateLabel.text = CustomDateFormatter.string(from: nextDate)
        ImageCache.load(urlString: subscription.imageUrl) { image in
            self.imageView.image = image ?? .logo
        }
    }

    /// 구독 시작일을 전달하면 오늘 이후 가장 가까운 다음 구독일을 반환합니다.
    func nextDate(from startDate: Date) -> Date? {
        let startDateComponents = Calendar.current.dateComponents([.day], from: startDate)
        let today = Date()
        let nextDate = Calendar.current.nextDate(
            after: today,
            matching: startDateComponents,
            matchingPolicy: .previousTimePreservingSmallerComponents,
            repeatedTimePolicy: .first,
            direction: .forward
        )
        return nextDate
    }

}
