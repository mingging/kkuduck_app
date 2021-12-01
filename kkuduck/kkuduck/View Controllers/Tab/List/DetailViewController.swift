//
//  DetailViewController.swift
//  kkuduck
//
//  Created by heyji on 2021/11/23.
//

import UIKit
import Charts

class DetailViewController: UIViewController {

    // MARK: - Properties
    var subscription: Subscription?
    var index: Int?

    private enum Metric {
        static let cornerRadius: CGFloat = 15
        static let shadowOffset: CGSize = CGSize(width: 1, height: 2)
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity: Float = 0.2
    }

    // MARK: - Outlets
    @IBOutlet var detailCellView: UIView!
    @IBOutlet var subscriptionNameLabel: UILabel!
    @IBOutlet var detailsubscriptionNameLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var subscriptionDDayLabel: UILabel!
    @IBOutlet var planNameLabel: UILabel!
    @IBOutlet var planPriceLabel: UILabel!
    @IBOutlet var planCycleLabel: UILabel!
    @IBOutlet var shareCountLabel: UILabel!
    @IBOutlet var shareIdLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var nextDateLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let subscription = subscription else {
            return
        }

        subscriptionNameLabel.text = subscription.serviceName
        detailsubscriptionNameLabel.text = subscription.serviceName
        subscriptionDDayLabel.text = "\(DDay(subscription.startDate))"
        ImageCache.load(urlString: subscription.imageUrl) { image in
            self.logoImageView.image = image ?? .logo
        }
        planNameLabel.text = subscription.planName
        planPriceLabel.text = "\(subscription.planPrice)원"
        planCycleLabel.text = subscription.cycle.rawValue
        shareCountLabel.text = "\(subscription.shareCount)명"
        shareIdLabel.text = subscription.shareId
        startDateLabel.text = CustomDateFormatter.string(from: subscription.startDate)
        if subscription.endDate != nil {
            endDateLabel.text = CustomDateFormatter.string(from: subscription.endDate!)
        } else {
            endDateLabel.text = "-"
        }
//        nextDateLabel.text

    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)

    }

    @IBAction func editButton(_ sender: UIButton) {
        // TODO: 수정 버튼을 누르면 addView로 이동
        LocalSubscriptionRepository.save(subscription: subscription!)

    }

    @IBAction func deleteButton(_ sender: UIButton) {
        LocalSubscriptionRepository.delete(at: index!)
        navigationController?.popViewController(animated: true)
    }

    private func setupView() {
        editButton.layer.cornerRadius = Metric.cornerRadius
        editButton.layer.shadowColor = UIColor.black.cgColor
        editButton.layer.shadowOpacity = Metric.shadowOpacity
        editButton.layer.shadowRadius = Metric.shadowRadius
        editButton.layer.shadowOffset = Metric.shadowOffset
        editButton.layer.masksToBounds = false
        editButton.layer.shadowPath = UIBezierPath(roundedRect: editButton.bounds, cornerRadius: editButton.layer.cornerRadius).cgPath

        deleteButton.layer.cornerRadius = Metric.cornerRadius
        deleteButton.layer.shadowColor = UIColor.black.cgColor
        deleteButton.layer.shadowOpacity = Metric.shadowOpacity
        deleteButton.layer.shadowRadius = Metric.shadowRadius
        deleteButton.layer.shadowOffset = Metric.shadowOffset
        deleteButton.layer.masksToBounds = false
        deleteButton.layer.shadowPath = UIBezierPath(roundedRect: deleteButton.bounds, cornerRadius: deleteButton.layer.cornerRadius).cgPath
    }

    func DDay(_ startDate: Date) -> Int {
        guard let subscription = subscription else {
            return 0
        }
        let now = Date()
        return Calendar.current.dateComponents([.day], from: subscription.startDate, to: now).day! + 1
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
