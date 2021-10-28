//
//  StartMainViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit
import SDWebImage


class StartMainViewController: UIViewController {

    @IBOutlet weak var lblStartinfo: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblUserName: UITextField!
    
    let startStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // label lineheight 조정
        let attrString = NSMutableAttributedString(string: lblStartinfo.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        lblStartinfo.attributedText = attrString
        // Do any additional setup after loading the view.
        
        // navigation bar 없애기
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // button round 조정
        btnStart.backgroundColor = .white
        btnStart.layer.cornerRadius = 10
        
        // plist 복사
        let targetPath = getFileName("writeSubscription.plist")
        print(targetPath)
        
        guard let sourcePath = Bundle.main.path(forResource: "writeSubscription", ofType: "plist") else { return }
        let FileManager = FileManager.default
        if !FileManager.fileExists(atPath: targetPath) {
            do {
                try FileManager.copyItem(atPath: sourcePath, toPath: targetPath)
            } catch {
                print("복사 실패")
            }

        }
        
        
    }
    
    // 페이지 이동
    @IBAction func btnStart(_ sender: UIButton) {
        
        
        // ADD Tab Bar 페이지로 변경
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController)
        
        
//        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else { return }
//          self.navigationController?.pushViewController(homeVC, animated: true)
        
        // ADD userID 저장
        UserDefaults.standard.set(lblUserName?.text, forKey: "userID")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

         self.view.endEditing(true)

   }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
