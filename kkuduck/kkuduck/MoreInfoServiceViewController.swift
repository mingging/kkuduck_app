//
//  MoreInfoServiceViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit
import DropDown

class MoreInfoServiceViewController: UIViewController, UITextFieldDelegate {

    var writeSubInfo: NSMutableArray?
    var dateInfo: String?
    var subInfo: [String:Any]!
    var planName: [String] = [""]
    var planPrice: [String] = [""]
    var cycle: String = ""
    var dataPrice: String = ""
    
    @IBOutlet weak var viewDorpDown: UIView!
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblPlanPrice: UILabel!
    @IBOutlet weak var btnSubAdd: UIButton!
    @IBOutlet weak var textPlanName: UITextField!
    @IBOutlet weak var textSubID: UITextField!
    @IBOutlet weak var dateSubstartday: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textSubID.delegate = self
            
        tabBarController?.tabBar.isHidden = true
        viewDorpDown.layer.cornerRadius = 5
        btnSubAdd.layer.cornerRadius = 5
        
        lblPlanName.text = ""
        lblPlanPrice.text = ""]
   
        // 데이터 불러오기
        self.writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
    }
    
    @IBAction func actBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionDropDown(_ sender: UIButton) {
        let dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = viewDorpDown // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        // 가져온 플랜 적용하기
        let subInfoPlans = subInfo["plan"] as? [String:String]
       
        guard let subInfoPlan = subInfoPlans else {return}

        planName = Array(subInfoPlan.keys)
        planPrice = Array(subInfoPlan.values)
        dropDown.dataSource = planName
        
        // custom dropdown cell
        dropDown.cellNib = UINib(nibName: "DropDownCell", bundle: nil)
        dropDown.customCellConfiguration = {index, title, cell in
            guard let cell = cell as? MyCell else {return}
            cell.optionLabel.text = self.planName[index]
            
            
            let str = self.planPrice[index].components(separatedBy: "/")
            let won = self.planPrice[index].components(separatedBy: "원")
            self.cycle = str[str.count - 1]
            self.dataPrice = won[0]
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            cell.testText.text = "\(numberFormatter.string(for: Int(self.dataPrice))!)/\(self.cycle)"
        }
        
        // 선택한 값 출력
        dropDown.selectionAction = { (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.lblPlanName.text = self.planName[index]
            self.lblPlanPrice.text = self.planPrice[index]
            let str = self.planPrice[index].components(separatedBy: "/")
            let won = self.planPrice[index].components(separatedBy: "원")
            self.cycle = str[str.count - 1]
            self.dataPrice = won[0]
            print(self.cycle)
            print(self.dataPrice)
        }
        
        dropDown.backgroundColor = UIColor.white
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.cellHeight = 64
        dropDown.cornerRadius = 5
        dropDown.show()
    }
    
    // 구독 서비스 추가 버튼
    @IBAction func actDone(_ sender: Any) {
        let subserviceID = textSubID.text
        let subStartDay = dateInfo
        let cycle = self.cycle
        let planPrice = self.dataPrice
        let img = subInfo["img"] as! String
        guard let subName = subInfo["subName"] as? String else {return}

        let writeSub = ["planName": subName, "subserviceID": subserviceID, "subStartDay": subStartDay, "cycle": cycle, "planPrice": planPrice, "img" : img]
        
        guard let writeSubInfo = self.writeSubInfo else { return }
        writeSubInfo.add(writeSub)
        writeSubInfo.write(toFile: getFileName("writeSubscription.plist"), atomically: true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actDatePicker(_ sender: Any) {
        let date = dateSubstartday.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dateInfo = formatter.string(from: date)
    }
    
    // textfield 입력시 keyboard 제어
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func onThridVCAction(data: [String:Any]) {
        self.subInfo = data
    }

}
