//
//  MoreInfoServiceViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit
import DropDown

class MoreInfoServiceViewController: UIViewController {

    @IBOutlet weak var viewDorpDown: UIView!
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblPlanPrice: UILabel!
    @IBOutlet weak var btnSubAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
        viewDorpDown.layer.cornerRadius = 5
        btnSubAdd.layer.cornerRadius = 5
    }
    
    @IBAction func actBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func actionDropDown(_ sender: UIButton) {
        let dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = viewDorpDown // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]

//        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
//        dropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
//
//        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> VoCellConfigurationClosureid in
//           guard let cell = cell as? MyCell else { return }
//
//           // Setup your custom UI components
//           cell.logoImageView.image = UIImage(named: "logo_\(index)")
//        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/

        
        
        
//        dropDown.customCellConfiguration { (index: Index, item: String, cell: CustomDropDownTableViewCell) -> Void in
//           guard let cell = cell as? CustomDropDownTableViewCell else { return }
        dropDown.backgroundColor = UIColor.white
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.cornerRadius = 5
        dropDown.show()

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

