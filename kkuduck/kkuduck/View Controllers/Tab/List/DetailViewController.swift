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
    @IBOutlet var editButton: UIButton!
    @IBOutlet var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func editButton(_ sender: UIButton) {
        // 수정 버튼을 누르면 addView로 이동
    }

    @IBAction func deleteButton(_ sender: UIButton) {
        // 삭제 버튼을 누르면 테이블 뷰에서 삭제 됨
    }

    private func setupView() {
        editButton.layer.cornerRadius = 15
        editButton.layer.shadowColor = UIColor.black.cgColor
        editButton.layer.shadowOpacity = 0.2
        editButton.layer.shadowRadius = 10
        editButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        editButton.layer.masksToBounds = false
        editButton.layer.shadowPath = UIBezierPath(roundedRect: editButton.bounds, cornerRadius: editButton.layer.cornerRadius).cgPath

        deleteButton.layer.cornerRadius = 15
        deleteButton.layer.shadowColor = UIColor.black.cgColor
        deleteButton.layer.shadowOpacity = 0.2
        deleteButton.layer.shadowRadius = 10
        deleteButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        deleteButton.layer.masksToBounds = false
        deleteButton.layer.shadowPath = UIBezierPath(roundedRect: deleteButton.bounds, cornerRadius: deleteButton.layer.cornerRadius).cgPath
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
