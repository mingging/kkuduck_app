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

    func configure(with subscription: Subscription) {
        nameLabel.text = subscription.name
        thumbnailImageView.image = UIImage(named: "logo.png") // TODO: image 수정
        cycleLabel.text = subscription.cycle
        priceLabel.text = "\(subscription.price) 원"
        let nextDate = nextDate(from: subscription.startDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        nextDateLabel.text = formatter.string(from: nextDate!)
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
