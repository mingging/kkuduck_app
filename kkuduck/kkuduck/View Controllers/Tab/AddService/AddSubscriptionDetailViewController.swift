//
//  AddSubscriptionDetailViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit
import DropDown
import Charts

final class AddSubscriptionDetailViewController: UIViewController {

    private enum Metric {
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - Properties

    var defaultSubscription: DefaultSubscription?
    var selectedPlan: DefaultSubscription.Plan! {
        didSet {
            self.planNameLabel.text = selectedPlan.name
            self.planPriceLabel.text =  "\(selectedPlan.price)원/\(selectedPlan.cycle.rawValue)"
        }
    }
    var shareCount: Int = 1 {
        didSet {
            self.shareCountLabel.text = "\(shareCount)명"
        }
    }

    // MARK: - Outlets

    // Default

    @IBOutlet weak var defaualtSubscriptionView: UIStackView!
    @IBOutlet weak var planMenuView: UIView!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var planPriceLabel: UILabel!
    lazy var planMenu: DropDown = {
        let dropDown = DropDown()
        dropDown.anchorView = planMenuView
        dropDown.backgroundColor = .white
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.cellHeight = 64
        dropDown.cornerRadius = Metric.cornerRadius
        dropDown.cellNib = UINib(nibName: SelectPlanCell.reuseIdentifier, bundle: nil)
        return dropDown
    }()

    // Custom

    @IBOutlet weak var customSubscriptionView: UIStackView!
    @IBOutlet weak var serviceNameTextField: UITextField!
    @IBOutlet weak var planNameTextField: UITextField!
    @IBOutlet weak var planPriceTextField: UITextField!

    // Common

    @IBOutlet weak var shareCountLabel: UILabel!
    @IBOutlet weak var shareCountStepper: UIStepper!
    @IBOutlet weak var cycleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var startDateDatePicker: UIDatePicker!
    @IBOutlet weak var shareIdTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        doneButton.layer.cornerRadius = Metric.cornerRadius
        shareCountStepper.layer.cornerRadius = Metric.cornerRadius
        startDateDatePicker.backgroundColor = .white
        startDateDatePicker.layer.cornerRadius = Metric.cornerRadius
        startDateDatePicker.layer.masksToBounds = true

        if let defaultSubscription = defaultSubscription {
            customSubscriptionView.removeFromSuperview()
            planMenuView.layer.cornerRadius = Metric.cornerRadius
            selectedPlan = defaultSubscription.plans[0]
            planMenu.dataSource = defaultSubscription.plans.map { $0.name }
            planMenu.customCellConfiguration = { index, _, cell in
                guard let cell = cell as? SelectPlanCell else { return }
                let plan = defaultSubscription.plans[index]
                cell.configure(with: plan)
            }
            planMenu.selectionAction = { index, _ in
                self.selectedPlan = defaultSubscription.plans[index]
            }
        } else {
            defaualtSubscriptionView.removeFromSuperview()
        }
    }

    // MARK: - Actions

    @IBAction func planMenuViewDidTap(_ sender: Any) {
        planMenu.show()
    }

    @IBAction func doneButtonDidTap(_ sender: Any) {
        var subscription: Subscription!
        if let defaultSubscription = defaultSubscription, let selectedPlan = selectedPlan {
            subscription = Subscription(
                serviceName: defaultSubscription.name,
                planName: selectedPlan.name,
                planPrice: selectedPlan.price,
                cycle: selectedPlan.cycle,
                shareCount: shareCount,
                startDate: startDateDatePicker.date,
                endDate: nil,
                imageUrl: defaultSubscription.imageUrl,
                shareId: shareIdTextField.text
            )
        } else {
            if let serviceName = serviceNameTextField.text,
               let planName = planNameTextField.text,
               let planPrice = Int(planPriceTextField.text!) {
                subscription = Subscription(
                    serviceName: serviceName,
                    planName: planName,
                    planPrice: planPrice,
                    cycle: Cycle.allCases[cycleSegmentedControl.selectedSegmentIndex],
                    shareCount: shareCount,
                    startDate: startDateDatePicker.date,
                    endDate: nil,
                    imageUrl: "",
                    shareId: shareIdTextField.text
                )
            }
        }
        LocalSubscriptionRepository.save(subscription: subscription)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func shareCountStepperValueChanged(_ sender: UIStepper) {
        shareCount = Int(sender.value)
    }
    // textfield 입력시 keyboard 제어
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}

// MARK: - UITextFieldDelegate

extension AddSubscriptionDetailViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case planPriceTextField:
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        default:
            return true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case planNameTextField:
            planPriceTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }

}
