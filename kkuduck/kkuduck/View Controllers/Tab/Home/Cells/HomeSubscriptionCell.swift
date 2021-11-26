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
        let nextDate = nextSubscriptionDate(from: subscription.startDate, matching: subscription.cycle)!
        nextDateLabel.text = CustomDateFormatter.string(from: nextDate)
        ImageCache.load(urlString: subscription.imageUrl) { image in
            self.imageView.image = image ?? .logo
        }
    }

    // MARK: -

    /// 주어진 구독 시작일과 결제 주기에 해당하는 다음 결제 예정일을 계산합니다.
    ///
    /// - Parameter startDate: 구독 시작일
    /// - Parameter component: 결제 주기
    /// - Returns: 다음 결제 예정일
    private func nextSubscriptionDate(from startDate: Date, matching cycle: Cycle) -> Date? {
        let today = Date()
        if startDate > today {
            return startDate
        }
        let startDateComponents = Calendar.current.dateComponents(cycle.matchingComponents, from: startDate)
        return Calendar.current.nextDate(
            after: today,
            matching: startDateComponents,
            matchingPolicy: .previousTimePreservingSmallerComponents,
            repeatedTimePolicy: .first,
            direction: .forward
        )
    }

}

// MARK: - Cycle 

fileprivate extension Cycle {
    var matchingComponents: Set<Calendar.Component> {
        switch self {
        case .month:
            return [.day]
        case .year:
            return [.month, .day]
        }
    }
}
