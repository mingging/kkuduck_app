//
//  MyCell.swift
//  kkuduck
//
//  Created by minimani on 2021/10/28.
//

import UIKit
import DropDown

class MyCell: DropDownCell {
    
    @IBOutlet var testText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
