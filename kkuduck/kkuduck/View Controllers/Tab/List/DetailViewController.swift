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
        static let shadowOffset: CGSize = CGSize(width: 1, height: 2)
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity: Float = 0.2
    }

    // MARK: - Properties

    var subscription: Subscription?

    // MARK: - Outlets

    @IBOutlet weak var detailCellView: UIView!
    @IBOutlet weak var subscriptionNameLabel: UILabel!
    @IBOutlet weak var detailsubscriptionNameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var subscriptionDDayLabel: UILabel!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var planPriceLabel: UILabel!
    @IBOutlet weak var planCycleLabel: UILabel!
    @IBOutlet weak var shareCountLabel: UILabel!
    @IBOutlet weak var shareIdLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var nextDateLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        configure(with: subscription)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupView() {
        editButton.layer.cornerRadius = Metric.cornerRadius
        editButton.layer.shadowColor = UIColor.black.cgColor
        editButton.layer.shadowOpacity = Metric.shadowOpacity
        editButton.layer.shadowRadius = Metric.shadowRadius
        editButton.layer.shadowOffset = Metric.shadowOffset
        editButton.layer.masksToBounds = false
        editButton.layer.shadowPath = UIBezierPath(
            roundedRect: editButton.bounds,
            cornerRadius: editButton.layer.cornerRadius
        ).cgPath

        deleteButton.layer.cornerRadius = Metric.cornerRadius
        deleteButton.layer.shadowColor = UIColor.black.cgColor
        deleteButton.layer.shadowOpacity = Metric.shadowOpacity
        deleteButton.layer.shadowRadius = Metric.shadowRadius
        deleteButton.layer.shadowOffset = Metric.shadowOffset
        deleteButton.layer.masksToBounds = false
        deleteButton.layer.shadowPath = UIBezierPath(
            roundedRect: deleteButton.bounds,
            cornerRadius: deleteButton.layer.cornerRadius
        ).cgPath
    }

    private func configure(with: Subscription?) {
        guard let subscription = subscription else { return }

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

        if let endDate = subscription.endDate {
            endDateLabel.text = DateHelper.string(from: endDate)
        } else {
            endDateLabel.text = "-"
        }
    }

    private func DDay(_ startDate: Date) -> Int {
        guard let subscription = subscription else {
            return 0
        }
        let now = Date()
        return Calendar.current.dateComponents([.day], from: subscription.startDate, to: now).day! + 1
    }

    // MARK: - Actions

    @IBAction func editButtonDidTap(_ sender: UIButton) {
        let current = Date()
        endDateLabel.text = DateHelper.string(from: current)
        SubscriptionRepository.shared.update(endDate: current, for: subscription!)
    }

    @IBAction func deleteButtonDidTap(_ sender: UIButton) {
        SubscriptionRepository.shared.delete(subscription: subscription!)
        navigationController?.popViewController(animated: true)
    }

}
