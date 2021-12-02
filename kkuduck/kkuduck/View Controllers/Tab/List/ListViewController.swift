//
//  ViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit
import Alamofire

final class ListViewController: UIViewController {

    // MARK: - Properties

    private var subscriptions: [Subscription] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet var addSubscriptionButton: UIButton!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)

        subscriptions = SubscriptionRepository.shared.subscriptions()

        guard let font = UIFont(name: "GmarketSansMedium", size: 12) else { return }
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        addSubscriptionButton.layer.cornerRadius = 25
        addSubscriptionButton.layer.shadowColor = UIColor.black.cgColor
        addSubscriptionButton.layer.shadowOpacity = 0.2
        addSubscriptionButton.layer.shadowRadius = 10
        addSubscriptionButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        addSubscriptionButton.layer.masksToBounds = false
        addSubscriptionButton.layer.shadowPath = UIBezierPath(roundedRect: addSubscriptionButton.bounds, cornerRadius: addSubscriptionButton.layer.cornerRadius).cgPath
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func subscriptionsWithEndDate(_ subscriptions: [Subscription]) -> [Subscription] {
        var subscriptionsWithEndDate: [Subscription] = []
        for i in 0..<subscriptions.count {
            if subscriptions[i].endDate != nil {
                subscriptionsWithEndDate.append(subscriptions[i])
            }
        }
        return subscriptionsWithEndDate
    }

    func subscriptionsWithoutEndDate(_ subscriptions: [Subscription]) -> [Subscription] {
        var subscriptionsWithoutEndDate: [Subscription] = []
        for i in 0..<subscriptions.count {
            if subscriptions[i].endDate == nil {
                subscriptionsWithoutEndDate.append(subscriptions[i])
            }
        }
        return subscriptionsWithoutEndDate
    }

    // MARK: - Configurations

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - TODO
    // 세그먼트를 선택하면 각각의 세그먼트에 관한 데이터를 불러옴
    // 만료됨 세그먼트를 선택하면 cell에 회색의 블라인드 처리

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            returnValue = subscriptionsWithoutEndDate(subscriptions).count
        case 1:
            returnValue = subscriptionsWithEndDate(subscriptions).count
        default:
            break
        }
        return returnValue
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListSubscriptionCell.reuseIdentifier, for: indexPath) as! ListSubscriptionCell

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // TODO: 만료일이 만료일이 없을 경우 함수 구현
            let subscription = subscriptionsWithoutEndDate(subscriptions)[indexPath.row]
            cell.endCellView.backgroundColor = .clear
            ImageCache.load(urlString: subscription.imageUrl) { image in
                cell.subscriptionImageView.image = image ?? .logo
            }
            cell.subscriptionNameLabel.text = subscription.serviceName
            cell.priceLabel.text = "\(subscription.planPrice)원 / \(subscription.cycle.rawValue)"
            break
        case 1:
            // TODO: 만료일이 있는 경우 함수 구현
            let subscription = subscriptionsWithEndDate(subscriptions)[indexPath.row]
            cell.endCellView.backgroundColor = .systemGray6
            cell.endCellView.alpha = 0.5
            ImageCache.load(urlString: subscription.imageUrl) { image in
                cell.subscriptionImageView.image = image ?? .logo
            }
            cell.subscriptionNameLabel.text = "0"
            cell.priceLabel.text = "0"
            break
        default:
            break
        }

        return cell
        // 데이터 불러오기
        //        guard let item = writeSubInfo?[indexPath.row] as? [String: Any] else { return cell }
        //
        //        cell.subscriptionNameLabel.text = item["planName"] as? String
        //        guard let thumImage = item["img"] as? String else { return cell }
        //
        //        // TODO: image 수정
        //        cell.subscriptionImageView.image = UIImage(named: "logo.png")
        //        cell.stratDateLabel.text = item["subStartDay"] as? String
        //
        //        guard let price = item["planPrice"] as? String else { return cell }
        //        guard let cycle = item["cycle"] as? String else { return cell }
        //        let numberFormatter = NumberFormatter()
        //        numberFormatter.numberStyle = .decimal
        //        cell.priceLabel.text = "\(numberFormatter.string(for: Int(price))!)원/\(cycle)"

    }

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         switch segmentedControl.selectedSegmentIndex {
         case 0:
             if let destVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                 destVC.subscription = subscriptionsWithoutEndDate(subscriptions)[indexPath.row]
             }
         case 1:
             if let destVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                 destVC.subscription = subscriptionsWithEndDate(subscriptions)[indexPath.row]
             }
         default:
             break
         }
     }

}
