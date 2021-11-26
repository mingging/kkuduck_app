//
//  StartMainViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit

final class LoginViewController: UIViewController {

    private enum Metric {
        static let cornerRadius: CGFloat = 15
    }

    // MARK: - Outlets

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var usernameLabel: UITextField!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        startButton.layer.cornerRadius = 5
    }

    // MARK: - Actions

    @IBAction func startButtonDidTap(_ sender: UIButton) {
        let tabBarController = UIStoryboard.main.instantiateViewController(withIdentifier: TabBarController.self)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
        UserDefaults.standard.set(usernameLabel?.text, forKey: UserDefaults.Keys.username.rawValue)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
