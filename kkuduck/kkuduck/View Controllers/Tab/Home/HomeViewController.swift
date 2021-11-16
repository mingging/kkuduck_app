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
        
        // cell round 조정
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        // cell shadow 추가
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        
        // servicelogo round 조정
        let viewServiceLogo = cell.viewWithTag(10)
        viewServiceLogo?.layer.cornerRadius = (viewServiceLogo?.frame.height)! / 2
        
        // 데이터 넣기
        guard let writeSubInfo = writeSubInfo,
              let item = writeSubInfo[indexPath.row] as? [String: Any] else { return cell }
        
        let name = item["planName"] as? String
        let cycle = item["cycle"] as? String
        let price = item["planPrice"] as! String
        //  thumbnil
        let imageUrlString = item["img"] as? String
        let imageUrl = URL(string: imageUrlString!)
        // nextDate
        let startDateString = item["subStartDay"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let startDate = formatter.date(from: startDateString!)
        let nextDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate!)
        
        cell.nameLabel.text = name
        cell.cycleLabel.text = cycle
        cell.priceLabel.text = "\(price) 원"
        cell.thumbnailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "logo.png"))
        cell.nextDateLabel.text = formatter.string(from: nextDate!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    
}
