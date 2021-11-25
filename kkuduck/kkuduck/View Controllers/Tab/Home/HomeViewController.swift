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
    }
    // MARK: - Properties

    private var subscriptions: [Subscription] = []

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
            self.usernameLabel.text = UserDefaults.standard.string(forKey: "userID")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchSubscriptions()
        collectionView.reloadData()
    }

    private func setupView() {
        totalPriceView.layer.cornerRadius = Metric.cornerRadius
    }

    private func fetchSubscriptions() {
        LocalSubscriptionRepository.items { subscriptions in
            self.subscriptions = subscriptions ?? []
        }
        countLabel.text = String(subscriptions.count)
        totalPriceLabel.text = String(subscriptions.map { $0.planPrice }.reduce(0, +))
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
        let cellShadowRadius: CGFloat = 15
        let cellWidth = width * 0.7
        let cellHeight = height - cellShadowRadius * 2
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }

}
