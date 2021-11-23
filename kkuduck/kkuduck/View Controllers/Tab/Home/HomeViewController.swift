//
//  MainViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties

    private var writeSubInfo: NSMutableArray?

    // MARK: - Outlets

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // view round 조정
        totalPriceView.layer.cornerRadius = 15

        // ADD 앱을 껐다가 켜도 이름이 저장되어 있도록 설정
        DispatchQueue.main.async {
            self.usernameLabel.text = UserDefaults.standard.string(forKey: "userID")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchSubscribes()
        collectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension HomeViewController {

    func fetchSubscribes() {
        writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        guard let writeSubInfo = writeSubInfo else { return }
        countLabel.text = String(writeSubInfo.count)
        totalPriceLabel.text = "\(totalPrice())"
    }

    /// 총 구독 금액
    func totalPrice() -> Int {
        guard let writeSubInfo = writeSubInfo else {
            fatalError()
        }
        let prices = writeSubInfo
            .map { $0 as! [String: Any] }
            .map { $0["planPrice"] as? Int ?? 0 }
            .reduce(0, +)
        return prices
    }

    func subscription(at row: Int) -> Subscription {
        guard let writeSubInfo = writeSubInfo,
            let item = writeSubInfo[row] as? [String: Any] else { fatalError() }

        let name = item["planName"] as! String
        let cycle = item["cycle"] as! String
        let price = item["planPrice"] as? Int ?? 0
        let imageUrl = item["img"] as! String
        let startDateString = item["subStartDay"] as? String ?? ""
        let startDate = CustomDateFormatter.date(from: startDateString) ?? Date()
        return Subscription(
            name: name,
            price: price,
            cycle: cycle,
            startDate: startDate,
            imageUrl: imageUrl
        )
    }

}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return writeSubInfo?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSubscriptionCell.reuseIdentifier, for: indexPath) as? HomeSubscriptionCell else {
            return UICollectionViewCell()
        }

        let subscription = subscription(at: indexPath.row)
        cell.configure(with: subscription)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let cellShadowRadius: CGFloat = 10
        let cellShadowOffsetHeight: CGFloat = 2
        let cellWidth = width * 0.7
        let cellHeight = height - cellShadowRadius * 2 - cellShadowOffsetHeight
        return CGSize(width: cellWidth, height: cellHeight)
    }

}
