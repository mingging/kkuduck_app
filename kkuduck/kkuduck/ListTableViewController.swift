//
//  ViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit
import Foundation

class ListTableViewController: UIViewController {

    var writeSubInfo: NSMutableArray?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hex: "#FDAC53ff")
        searchBar.endEditing(true)
        SearchBar()

        self.writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        // array의 참조 변수를 넘겨주는 방법 생각해보기
    }
    
    // 왜 테이블뷰에 리로드가 안 되는 것인가??? OK -> 중복코드 개선 방안 ....
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        self.tableView.reloadData()
    }

    
    func SearchBar() {
        searchBar.placeholder = "구독을 검색해보세요"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = UIColor(hex: "#FDAC53ff")
        searchBar.backgroundImage = UIImage()
    }
    
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 구독 중인 것들만 보여주기
        if let writeSubInfo = self.writeSubInfo {
            return writeSubInfo.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // cell을 라운드 형식으로
        cell.cellView.layer.cornerRadius = 15
        
        // tableviewcell 의 shadow
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 0.2
        cell.cellView.layer.shadowRadius = 10
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.cellView.layer.masksToBounds = false
        
        
        // 데이터 불러오기
        guard let writeSubInfo = self.writeSubInfo,
              let item = writeSubInfo[indexPath.row] as? [String:Any]
        else { return cell }
        
        cell.lblSubName.text = item["planName"] as? String
        guard let thumImage = item["img"] as? String else {return cell}
        cell.subImage.sd_setImage(with: URL(string: thumImage), placeholderImage: UIImage(named: "logo.png"))
        cell.lblSubStartday.text = item["subStartDay"] as? String

        guard let price = item["planPrice"] as? String else {return cell}
        guard let cycle = item["cycle"] as? String else {return cell}
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        cell.lblPlanPrice.text = "\(numberFormatter.string(for: Int(price))!)원/\(cycle)"
        
        // D-day OK
        let calendar = Calendar.current
        let currentDate = Date()
        print(currentDate)
        func days(from date: Date) -> Int {
            return calendar.dateComponents([.day], from: date, to: currentDate).day! + 1
        }
        if let date = item["subStartDay"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            if let day = formatter.date(from: date) {
                let dDay = days(from: day)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd"
                cell.lblDDay.text = "D + \(dDay)"
            }
        }

        tableView.backgroundColor = UIColor(red: 253, green: 172, blue: 83, alpha: 0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // 테이블뷰에서 셀을 삭제하면 저장된 데이터도 삭제되도록 구현
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil, handler: {
            action, view, completionHandler in
            print("delete")
            
            self.writeSubInfo?.removeObject(at: indexPath.row)
            self.writeSubInfo?.write(toFile: getFileName("writeSubscription.plist"), atomically: true)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        })
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = UIColor(red: 253, green: 172, blue: 83, alpha: 0)
        
        return UISwipeActionsConfiguration(actions: [action])
    }
        
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil, handler: {
            action, view, completionHandler in
            print("delete")
            
            self.writeSubInfo?.removeObject(at: indexPath.row)
            self.writeSubInfo?.write(toFile: getFileName("writeSubscription.plist"), atomically: true)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        })
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = UIColor(red: 253, green: 172, blue: 83, alpha: 0)
        
        return UISwipeActionsConfiguration(actions: [action])
    }

}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
