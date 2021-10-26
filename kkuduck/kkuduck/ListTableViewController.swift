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
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        
        
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
        cell.inimageView.layer.cornerRadius = cell.inimageView.frame.size.width/2
        cell.inimageView.clipsToBounds = true
        
        // tableviewcell 의 shadow
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 0.5
        cell.cellView.layer.shadowRadius = 5
        cell.cellView.layer.shadowOffset = CGSize(width: 0, height: 5)
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



