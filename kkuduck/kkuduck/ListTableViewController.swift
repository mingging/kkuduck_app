//
//  ViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit
import Foundation

class ListTableViewController: UIViewController {
    var subService: NSArray?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Subscription()
        SearchBar()
        
//        CurrentDay()
    }

    func Subscription() {
        guard let path = Bundle.main.path(forResource: "writeSubscription", ofType: "plist") else { return }
        subService = NSArray(contentsOfFile: path)
        
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
        if let subService = self.subService {
            return subService.count
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
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 8
        
        // imageview를 원 모양으로 만들기
        cell.inimageView.layer.cornerRadius = cell.inimageView.frame.height / 2
        cell.inimageView.clipsToBounds = true
        
        // tableviewcell 의 shadow
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 0.2
        cell.cellView.layer.shadowRadius = 10
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.cellView.layer.masksToBounds = false
        
        guard let subService = self.subService,
              let item = subService[indexPath.row] as? [String:Any]
        else { return cell }
        
        
        
        cell.lblSubName.text = item["planName"] as? String
        cell.lblSubStartday.text = item["subStartDay"] as? String
        if let price = item["planPrice"] as? [String:Any] {
            cell.lblPlanPrice.text = price["베이직"] as? String
        } else {
            cell.lblPlanPrice.text = item["planPrice"] as? String
        }
        
        
//        let day =
//        cell.lblDDay.text = "D + \(day)"
        
        
        
        tableView.backgroundColor = UIColor(red: 253, green: 172, blue: 83, alpha: 0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
//    func CurrentDay() {
//        var formatter = DateFormatter()
//        formatter.dateFormat = "yyyy.MM.DD"
//        var currentDateString = formatter.string(from: Date())
//        print(CurrentDay())
//    }
    
    
    
    
    
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

