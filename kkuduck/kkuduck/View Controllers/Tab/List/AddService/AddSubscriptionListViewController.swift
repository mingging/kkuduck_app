//
//  AddSubscriptionListViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit

final class AddSubscriptionListViewController: UIViewController {

    private enum Segue: String {
        case showDetail
    }

    // MARK: - Properties

    var defaultSubscriptions: [DefaultSubscription] = []

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDefaultSubscription()
    }

    private func fetchDefaultSubscription() {
        let sampleData = DefaultSubscription.sampleData
        do {
            let services = try JSONDecoder().decode([DefaultSubscription].self, from: sampleData)
            self.defaultSubscriptions = services
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddSubscriptionDetailViewController else { return }
        destination.defaultSubscription = sender as? DefaultSubscription
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension AddSubscriptionListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultSubscriptions.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddSubscriptionCell.reuseIdentifier, for: indexPath) as? AddSubscriptionCell else {
            return UICollectionViewCell()
        }

        let defaultSubscription = indexPath.row == defaultSubscriptions.count ? nil : defaultSubscriptions[indexPath.row]
        cell.configure(with: defaultSubscription)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let defaultSubscription = indexPath.row == defaultSubscriptions.count ? nil : defaultSubscriptions[indexPath.row]
        performSegue(withIdentifier: Segue.showDetail.rawValue, sender: defaultSubscription)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }

}
