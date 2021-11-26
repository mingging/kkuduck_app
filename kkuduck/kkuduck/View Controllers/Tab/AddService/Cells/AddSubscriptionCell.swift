//
//  AddSubscriptionCell.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit

final class AddSubscriptionCell: UICollectionViewCell {

    private enum Metric {
        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 1
        static let shadowOffset: CGSize = CGSize(width: 1, height: 2)
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity: Float = 0.2
    }
    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        contentView.layer.cornerRadius = Metric.cornerRadius
        contentView.layer.borderWidth = Metric.borderWidth
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = Metric.shadowOffset
        layer.shadowRadius = Metric.shadowRadius
        layer.shadowOpacity = Metric.shadowOpacity
        layer.masksToBounds = false
    }

    func configure(with defaultSubscription: DefaultSubscription?) {
        if let defaultSubscription = defaultSubscription {
            nameLabel.text = defaultSubscription.name
            ImageCache.load(urlString: defaultSubscription.imageUrl) { image in
                self.imageView.image = image ?? .logo
            }
        } else {
            nameLabel.text = "추가하기"
            imageView.image = .plus
        }
    }

}
