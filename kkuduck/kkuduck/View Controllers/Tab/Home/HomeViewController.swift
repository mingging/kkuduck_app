//
//  MainViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit

final class HomeViewController: UIViewController {

    private enum Metric {
        static let cornerRadius: CGFloat = 15
        static let cellSpacing: CGFloat = 15
    }

    // MARK: - Properties

    private var subscriptions: [Subscription] = [] {
        didSet {
            DispatchQueue.main.async {
                self.countLabel.text = String(self.subscriptions.count)
                self.totalPriceLabel.text = self.subscriptions.map { $0.planPrice }.reduce(0, +).currencyString
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - Outlets

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        DispatchQueue.main.async {
            self.usernameLabel.text = UserDefaults.standard.string(forKey: UserDefaults.Keys.username.rawValue)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchSubscriptions()
        collectionView.setContentOffset(.zero, animated: true)
    }

    private func setupView() {
        totalPriceView.layer.cornerRadius = Metric.cornerRadius
    }

    private func fetchSubscriptions() {
        subscriptions = SubscriptionRepository.shared.subscriptions()
            .filter { $0.endDate == nil }
            .sorted {
                DateHelper.nextSubscriptionDate(from: $0.startDate, matching: $0.cycle)!
                < DateHelper.nextSubscriptionDate(from: $1.startDate, matching: $1.cycle)!
            }
    }

}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subscriptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSubscriptionCell.reuseIdentifier, for: indexPath) as? HomeSubscriptionCell else {
            return UICollectionViewCell()
        }

        let subscription = subscriptions[indexPath.row]
        cell.configure(with: subscription)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let cellWidth = width * 0.7
        let cellHeight = height - Metric.cellSpacing * 2
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(
            roundedRect: cell.bounds,
            cornerRadius: cell.contentView.layer.cornerRadius
        ).cgPath
    }

}
