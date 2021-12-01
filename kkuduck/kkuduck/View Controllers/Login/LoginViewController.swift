//
//  LoginViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/25.
//

import UIKit

final class LoginViewController: UIViewController {

    private enum Metric {
        static let cornerRadius: CGFloat = 5
    }

    // MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var usernameLabel: UITextField!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        registerKeyboardNotification()
    }

    private func setupView() {
        startButton.layer.cornerRadius = Metric.cornerRadius
    }

    // MARK: Keyboard Notification

    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                  return
              }
        var contentInset = UIEdgeInsets.zero
        contentInset.bottom += keyboardFrame.size.height
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    // MARK: - Actions

    @IBAction func startButtonDidTap(_ sender: UIButton) {
        let tabBarController = UIStoryboard.main.instantiateViewController(withIdentifier: TabBarController.self)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(tabBarController)
        UserDefaults.standard.set(usernameLabel?.text, forKey: UserDefaults.Keys.username.rawValue)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
