//
//  ViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - Properties

    private var writeSubInfo: NSMutableArray?

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()

        // TODO: array의 참조 변수를 넘겨주는 방법 생각해보기
//        writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
    }

    // TODO: 왜 테이블뷰에 리로드가 안 되는 것인가??? OK -> 중복코드 개선 방안 ....
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.navigationController?.setNavigationBarHidden(true, animated: false)

//        writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
//        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Configurations

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hex: "#FDAC53ff")
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.reuseIdentifier, for: indexPath) as! ServiceCell
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
//
//        // D-day OK
//       if let dateString = item["subStartDay"] as? String {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy.MM.dd"
//            if let date = formatter.date(from: dateString) {
//                let now = Date()
//                let dDay = Calendar.current.dateComponents([.day], from: date, to: now).day! + 1
//                cell.dDayLabel.text = "D + \(dDay)"
//            }
//        }
        return cell
    }

}

// 세그먼트를 선택하면 각각의 세그먼트에 관한 데이터를 불러옴
// 만료됨 세그먼트를 선택하면 cell에 회색의 블라인드 처리

// MARK: - UITableViewDelegate

 extension ListViewController: UITableViewDelegate {
//
//    // 테이블뷰에서 셀을 삭제하면 저장된 데이터도 삭제되도록 구현
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
//            self.writeSubInfo?.removeObject(at: indexPath.row)
//            self.writeSubInfo?.write(toFile: getFileName("writeSubscription.plist"), atomically: true)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            completionHandler(true)
//        }
//        action.image = UIImage(systemName: "trash")
//        action.backgroundColor = UIColor(red: 253, green: 172, blue: 83, alpha: 0)
//        return UISwipeActionsConfiguration(actions: [action])
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
//            self.writeSubInfo?.removeObject(at: indexPath.row)
//            self.writeSubInfo?.write(toFile: getFileName("writeSubscription.plist"), atomically: true)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            completionHandler(true)
//        }
//        action.image = UIImage(systemName: "trash")
//        action.backgroundColor = UIColor(red: 253, green: 172, blue: 83, alpha: 0)
//        return UISwipeActionsConfiguration(actions: [action])
//    }
//
 }
