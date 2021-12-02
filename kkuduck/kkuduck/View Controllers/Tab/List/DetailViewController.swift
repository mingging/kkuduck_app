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

    private enum Metric {
        static let cornerRadius: CGFloat = 15
    }

    // MARK: - Outlets
    @IBOutlet var detailCellView: UIView!
    @IBOutlet var endDetailCellView: UIView!
    @IBOutlet var endLabel: UILabel!
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
    @IBOutlet var endButton: UIButton!
    @IBOutlet var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        guard let subscription = subscription else {
            return
        }

        if subscription.endDate == nil {
            endDetailCellView.backgroundColor = .clear
            endLabel.textColor = .clear
        } else {
            endDetailCellView.backgroundColor = .systemGray4
            endDetailCellView.alpha = 0.5
            endButton.isEnabled = false
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
        startDateLabel.text = DateHelper.string(from: subscription.startDate)
        if subscription.endDate != nil {
            endDateLabel.text = DateHelper.string(from: subscription.endDate!)
        } else {
            endDateLabel.text = "-"
        }
        let nextDate = DateHelper.nextSubscriptionDate(from: subscription.startDate, matching: subscription.cycle)
        nextDateLabel.text = DateHelper.string(from: nextDate!)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func endButton(_ sender: UIButton) {
        // TODO: 만료 버튼을 누르면 만료일 생성 후 업데이트
        let endDate = Date()
        endDateLabel.text = DateHelper.string(from: endDate)

        SubscriptionRepository.shared.save(subscription: subscription!)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteButton(_ sender: UIButton) {
        let deleteAlert = UIAlertController(title: "", message: "구독 정보를 정말로 삭제하시겠습니까?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "취소", style: .default) { _ in
            print("취소했습니다.")
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            SubscriptionRepository.shared.delete(subscription: self.subscription!)
            CheckServiceChange.shared.isServiceAdd = true
            self.navigationController?.popViewController(animated: true)
        }
        deleteAlert.addAction(cancleAction)
        deleteAlert.addAction(deleteAction)
        present(deleteAlert, animated: true)
    }

    private func setupView() {
        endButton.layer.cornerRadius = Metric.cornerRadius
        endButton.layer.masksToBounds = false

        deleteButton.layer.cornerRadius = Metric.cornerRadius
        deleteButton.layer.masksToBounds = false
    }

    private func DDay(_ startDate: Date) -> Int {
        guard let subscription = subscription else {
            return 0
        }
        let now = Date()
        return Calendar.current.dateComponents([.day], from: subscription.startDate, to: now).day! + 1
    }
}
