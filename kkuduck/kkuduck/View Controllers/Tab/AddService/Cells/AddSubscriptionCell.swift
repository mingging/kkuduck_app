//
//  AddSubscriptionCell.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit

final class AddSubscriptionCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
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
