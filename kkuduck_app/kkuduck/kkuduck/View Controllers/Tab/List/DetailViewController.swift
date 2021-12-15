//
//  DetailViewController.swift
//  kkuduck
//
//  Created by heyji on 2021/11/23.
//

import UIKit

final class DetailViewController: UIViewController {

    private enum Metric {
        static let cornerRadius: CGFloat = 15
    }

    // MARK: - Properties

    var subscription: Subscription?
    var endDate: Date? {
        didSet {
            if let endDate = endDate {
                detailContainerView.backgroundColor = .systemGray4
                detailContainerView.alpha = 0.5
                endLabel.textColor = .label
                endButton.isEnabled = false
                endDateLabel.text = DateHelper.string(from: endDate)
            } else {
                detailContainerView.backgroundColor = .clear
                detailContainerView.alpha = 1
                endLabel.textColor = .clear
                endDateLabel.text = "-"
            }
        }
    }

    // MARK: - Outlets

    @IBOutlet var detailContainerView: UIStackView!
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

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        setupView()
        configure(with: subscription)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupView() {
        endButton.layer.cornerRadius = Metric.cornerRadius
        endButton.layer.masksToBounds = false
        deleteButton.layer.cornerRadius = Metric.cornerRadius
        deleteButton.layer.masksToBounds = false
    }

    private func configure(with: Subscription?) {
        guard let subscription = subscription else { return }
        subscriptionNameLabel.text = subscription.serviceName.localized
        detailsubscriptionNameLabel.text = subscription.serviceName.localized
        subscriptionDDayLabel.text = "\(DDay(subscription.startDate))".localized
        ImageCache.load(urlString: subscription.imageUrl) { image in
            self.logoImageView.image = image ?? .logo
        }
        planNameLabel.text = subscription.planName.localized
        planPriceLabel.text = subscription.planPrice.currencyString
        planCycleLabel.text = subscription.cycle.rawValue.localized // 원래 subscription.cycle.rawValue
        shareCountLabel.text = "\(subscription.shareCount)".localized // 수정 "\(subscription.shareCount)명" 이었음
        shareIdLabel.text = subscription.shareId
        startDateLabel.text = DateHelper.string(from: subscription.startDate)
        let nextDate = DateHelper.nextSubscriptionDate(from: subscription.startDate, matching: subscription.cycle)
        nextDateLabel.text = DateHelper.string(from: nextDate!)?.localized // 수정
        endDate = subscription.endDate
    }

    private func DDay(_ startDate: Date) -> Int {
        guard let subscription = subscription else {
            return 0
        }
        let now = Date()
        return Calendar.current.dateComponents([.day], from: subscription.startDate, to: now).day! + 1
    }

    // MARK: - Actions

    @IBAction func endButtonDidTap(_ sender: UIButton) {
        let current = Date()
        endDate = current
        SubscriptionRepository.shared.update(endDate: current, for: subscription!)
    }

    @IBAction func deleteButtonDidTap(_ sender: UIButton) {
        let deleteAlert = UIAlertController(title: "", message: "구독 정보를 정말로 삭제하시겠습니까?".localized, preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "취소".localized, style: .default)
        let deleteAction = UIAlertAction(title: "삭제".localized, style: .destructive) { _ in
            SubscriptionRepository.shared.delete(subscription: self.subscription!)
            CheckServiceChange.shared.isServiceAdd = true
            self.navigationController?.popViewController(animated: true)
        }
        deleteAlert.addAction(cancleAction)
        deleteAlert.addAction(deleteAction)
        present(deleteAlert, animated: true)
    }

}
