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
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSubNum: UILabel!
    @IBOutlet weak var lblSumPrice: UILabel!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
       
        // view round 조정
        viewTotalSub.layer.cornerRadius = 15
        
        // ADD 앱을 껐다가 켜도 이름이 저장되어 있도록 설정
        DispatchQueue.main.async {
            self.lblName.text = UserDefaults.standard.string(forKey: "userID")
        }
        
        // 데이터 추가 후 저장된 데이터를 다시 불러오려면 어떻게 해야하는가
        saveData()
        
        // 총 구독 합계
        let totalP = totalPrice()
        lblSumPrice.text = totalP
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        saveData()
        collectionView.reloadData()

        total = 0
        let totalP = totalPrice()
        lblSumPrice.text = String(totalP)
    }

    // MARK: - Private Methods

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func saveData() {
        writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        guard let writeSubInfo = writeSubInfo else { return }
        lblSubNum.text = String(writeSubInfo.count)
        
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
        // TODO: Custom Cell 만들기
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

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
              let item = writeSubInfo[indexPath.row] as? [String: Any]
        else { return cell }
        let subName = cell.viewWithTag(1) as? UILabel
        subName?.text = item["planName"] as? String
        let cycle = cell.viewWithTag(2) as? UILabel
        cycle?.text = item["cycle"] as? String
        if let planPrice = cell.viewWithTag(4) as? UILabel {
            let price = item["planPrice"] as! String
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            planPrice.text = "\(numberFormatter.string(for: Int(price))!)원"
        }
        guard let thumImage = item["img"] as? String else {return cell}
        let thum = cell.viewWithTag(5) as? UIImageView
        if let thum = thum {
            thum.image = UIImage(named: "placeholder.png")
        }
            // 다음 결제일 계산 악!!!!!!
            // 낡지 힘내요..
        if let startDay = item["subStartDay"] as? String { // subStartDay -> string 형태로 형변환
            print(startDay) // 2021.10.27
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            if let day = formatter.date(from: startDay) {
                print(day) // 2021-10-09 15:00:00 +0000
                let calendar = Calendar.current
                if let componet = calendar.date(byAdding: .day, value: +30, to: day) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy.MM.dd"
                    let strday = formatter.string(from: componet)

                    let nextMonth = cell.viewWithTag(3) as? UILabel
                    nextMonth?.text = strday
                    print(strday)
                }
            }
        }

            // 결제일이 이른 순서로 나열... 악!!!!!
            // 현재 날짜부터 30일 이전의 구독은 보이지 않도록 구현
            // 현재 날짜에서 구독시작일에서 + 30일 했을때 현재 날짜보다 이전이면 추가로 +30 현재 날짜보다 이후면 그대로 두기

        return cell
    }

        // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }

}
