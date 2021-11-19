//
//  Subscribe.swift
//  kkuduck
//
//  Created by 홍다희 on 2021/11/16.
//

import Foundation

struct Subscribe {
    let subscription: Subscription
    let startDate: Date
}

struct Subscription {
    let name: String
    let imageUrl: String
    let price: Int
    let cycle: String
}
// let name = item["planName"] as? String
// let cycle = item["cycle"] as? String
// let price = item["planPrice"] as! String
////  thumbnil
// let imageUrlString = item["img"] as? String
// let imageUrl = URL(string: imageUrlString!)
//// nextDate
// let startDateString = item["subStartDay"] as? String
// let formatter = DateFormatter()
// formatter.dateFormat = "yyyy.MM.dd"
// let startDate = formatter.date(from: startDateString!)
// let nextDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate!)
//
// cell.nameLabel.text = name
// cell.cycleLabel.text = cycle
// cell.priceLabel.text = "\(price) 원"
// cell.thumbnailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "logo.png"))
// cell.nextDateLabel.text = formatter.string(from: nextDate!)
