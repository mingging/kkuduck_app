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
    
    override func awakeFromNib() {
        // cell round 조정
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        // cell shadow 추가
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        
        // servicelogo round 조정
        let viewServiceLogo = viewWithTag(10)
        viewServiceLogo?.layer.cornerRadius = (viewServiceLogo?.frame.height)! / 2
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
