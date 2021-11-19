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

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewTotalSub: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // view round 조정
        viewTotalSub.layer.cornerRadius = 15

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
            .map { $0["planPrice"] as! String }
            .map { Int($0)! }
            .reduce(0, +)
        return prices
    }

    func subscribe(at row: Int) -> Subscribe {
        guard let writeSubInfo = writeSubInfo,
            let item = writeSubInfo[row] as? [String: Any] else { fatalError() }

        let name = item["planName"] as! String
        let cycle = item["cycle"] as! String
        let priceString = item["planPrice"] as! String
        let price = Int(priceString)!
        let imageUrlString = item["img"] as! String
        let startDateString = item["subStartDay"] as! String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let startDate = formatter.date(from: startDateString)!
        let subscribe = Subscribe(
            subscription: Subscription(
                name: name,
                imageUrl: imageUrlString,
                price: price,
                cycle: cycle
            ),
            startDate: startDate
        )

        return subscribe
    }

}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return writeSubInfo?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSubscriptionCell.reuseIdentifier, for: indexPath) as? HomeSubscriptionCell else {
            return UICollectionViewCell()
        }

        let subscribe = subscribe(at: indexPath.row)
        cell.configure(with: subscribe)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }

}
