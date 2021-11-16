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
    private var total = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewTotalSub: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        // view round 조정
        viewTotalSub.layer.cornerRadius = 15
        
        // ADD 앱을 껐다가 켜도 이름이 저장되어 있도록 설정
        DispatchQueue.main.async {
            self.usernameLabel.text = UserDefaults.standard.string(forKey: "userID")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 데이터 추가 후 저장된 데이터를 다시 불러오려면 어떻게 해야하는가
        saveData()
        
        // 총 구독 합계
        let totalP = totalPrice()
        totalPriceLabel.text = totalP

        collectionView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func saveData() {
        writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        guard let writeSubInfo = writeSubInfo else { return }
        countLabel.text = String(writeSubInfo.count)
        
        // 총 구독 금액 구현
        // 딕셔너리에서 하나씩 빼서 배열로 나열 -> 합계 계산
    }
    
    private func totalPrice() -> String {
        guard let writeSubInfo = writeSubInfo else { return "" }
        
        let count = writeSubInfo.count
        for i in 0..<count {
            guard let item = writeSubInfo[i] as? [String: Any] else { return "" }
            if let price = item["planPrice"] as? String {
                if let intPrice = Int(price) {
                    total += intPrice
                }
            }
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let stringTotal =  numberFormatter.string(for: total)!
        
        return stringTotal
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
