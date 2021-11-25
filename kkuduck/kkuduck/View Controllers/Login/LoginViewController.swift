//
//  StartMainViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var lblStartinfo: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblUserName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // label lineheight 조정
        let attrString = NSMutableAttributedString(string: lblStartinfo.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        lblStartinfo.attributedText = attrString
        // Do any additional setup after loading the view.

        // navigation bar 없애기
        navigationController?.setNavigationBarHidden(true, animated: true)

        // button round 조정
        btnStart.backgroundColor = .white
        btnStart.layer.cornerRadius = 10

        // plist 복사
        let targetPath = LocalSubscriptionRepository.fileURL.path
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
        let tabBarController = UIStoryboard.main.instantiateViewController(identifier: "TabBarController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)

        // ADD userID 저장
        UserDefaults.standard.set(lblUserName?.text, forKey: "userID")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         view.endEditing(true)
   }

}
