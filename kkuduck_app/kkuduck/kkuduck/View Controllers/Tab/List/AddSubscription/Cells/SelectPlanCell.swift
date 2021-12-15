//
//  SelectPlanCell.swift
//  kkuduck
//
//  Created by minimani on 2021/10/28.
//

import UIKit
import DropDown

final class SelectPlanCell: DropDownCell {

    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func configure(with plan: DefaultSubscription.Plan) {
        optionLabel.text = "".localized
        nameLabel.text = plan.name.localized
        priceLabel.text = "\(plan.price.currencyString)/\(plan.cycle.rawValue)"
    }

}
