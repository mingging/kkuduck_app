//
//  CustomTableViewCell.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/25.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var subImage: UIImageView!
    @IBOutlet weak var lblSubName: UILabel!
    @IBOutlet weak var lblSubStartday: UILabel!
    @IBOutlet weak var lblPlanPrice: UILabel!
    @IBOutlet weak var lblDDay: UILabel!
    
    @IBOutlet weak var inimageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
