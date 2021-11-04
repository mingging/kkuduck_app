//
//  MoreInfoNewViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit

class MoreInfoNewViewController: UIViewController, UITextFieldDelegate {
    var writeSubInfo: NSMutableArray?
    var dateInfo: String? // 날짜를 받기 위한 전역 변수 설정
    
    @IBOutlet weak var textPlanName: UITextField!
    @IBOutlet weak var textPlanPrice: UITextField!
    @IBOutlet weak var textSubserviceID: UITextField!
    @IBOutlet weak var segCycle: UISegmentedControl!
    @IBOutlet weak var dateSubstartday: UIDatePicker!

    @IBOutlet weak var btnAddNew: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        btnAddNew.layer.cornerRadius = 5
        textPlanName.delegate = self
        textPlanPrice.delegate = self
        textSubserviceID.delegate = self
        
        // plist 복사
//        let targetPath = getFileName("writeSubscription.plist")
//        print(targetPath)
//
//        guard let sourcePath = Bundle.main.path(forResource: "writeSubscription", ofType: "plist") else { return }
//        let FileManager = FileManager.default
//        if !FileManager.fileExists(atPath: targetPath) {
//            do {
//                try FileManager.copyItem(atPath: sourcePath, toPath: targetPath)
//            } catch {
//                print("복사 실패")
//            }
//        }
        
        self.writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        // 파일을 doc에 복사해 옴. 이 파일에 데이터를 저장할 것임
        
    }
    
    @IBAction func actBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actDone(_ sender: UIButton) {
        // textField 데이터
        let planName = textPlanName.text
        let planPrice = textPlanPrice.text // 뒤에 "원" 붙여서 데이터 저장되도록 하고, 숫자 외엔 입력 못도록 설정
        let subserviceID = textSubserviceID.text
        let img = ""
        
        // segment 데이터
        let select = segCycle.selectedSegmentIndex
        let cycle = segCycle.titleForSegment(at: select) // seguement 입력 받는 방법 OK
        
        // datepicker 데이터
        let subStartDay = dateInfo
        
        let name = planName
        let price = planPrice
        let date = subStartDay
        
        if name == "" || price == "" || date == nil {
            if name == "" {
                alert(message: "구독 이름이 입력되지 않았습니다.")
            } else if price == "" {
                alert(message: "구독 가격이 입력되지 않았습니다.")
            } else if date == nil {
                alert(message: "구독 시작일이 입력되지 않았습니다.")
            } else {
                alert(message: "정보가 입력되지 않았습니다.")
            }
        } else {
            
            let writeSub = ["planName": planName, "planPrice": planPrice, "subserviceID": subserviceID, "cycle": cycle, "subStartDay": subStartDay, "img": img]
            
            guard let writeSubInfo = self.writeSubInfo else { return }
            print(writeSub)
            writeSubInfo.add(writeSub)
            writeSubInfo.write(toFile: getFileName("writeSubscription.plist"), atomically: true)
        }
        
        // 완료 버튼을 누르면 이전 화면으로 돌아가도록 구현 OK
        self.navigationController?.popViewController(animated: true)
        
    }
    func alert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    
    @IBAction func actDatePicker(_ sender: Any) {
        let date = dateSubstartday.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dateInfo = formatter.string(from: date)
        print(date)
        
        // 날짜 선택하면 dismiss 되도록
//        dismiss(animated: true)
    }
    
    
    // textfield 입력시 keyboard 제어
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destVC = segue.destination as? ListTableViewController else { return }
//        destVC.writeSubInfo = self.writeSubInfo
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
