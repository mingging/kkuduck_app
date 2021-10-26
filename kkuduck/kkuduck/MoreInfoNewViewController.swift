//
//  MoreInfoNewViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit

class MoreInfoNewViewController: UIViewController {

    @IBOutlet weak var btnAddNew: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        btnAddNew.layer.cornerRadius = 5
    }
    
    @IBAction func actBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
