//
//  DetailViewController.swift
//  kkuduck
//
//  Created by heyji on 2021/11/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailCellView: UIView!
    @IBOutlet var subscriptionNameLabel: UILabel!
    @IBOutlet var subscriptionDay: UILabel!
    @IBOutlet var planName: UILabel!
    @IBOutlet var planPrice: UILabel!
    @IBOutlet var planCycle: UILabel!
    @IBOutlet var userNum: UILabel!
    @IBOutlet var serviceId: UILabel!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var endDate: UILabel!
    @IBOutlet var nextDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func editButton(_ sender: UIButton) {
        // 수정 버튼을 누르면 addView로 이동
    }

    @IBAction func deleteButton(_ sender: UIButton) {
        // 삭제 버튼을 누르면 테이블 뷰에서 삭제 됨
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
