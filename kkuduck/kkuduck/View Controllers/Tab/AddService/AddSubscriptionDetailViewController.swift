//
//  AddSubscriptionDetailViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit
import DropDown

final class AddSubscriptionDetailViewController: UIViewController {

    private enum Metric {
        static let radius: CGFloat = 10
    }

    // MARK: - Properties

    var writeSubInfo: NSMutableArray?
    var defaultSubscription: DefaultSubscription?
    var selectedPlan: Plan!

    // MARK: - Outlets

    // Default

    @IBOutlet weak var selectPlanContainerView: UIStackView!
    @IBOutlet weak var selectPlanView: UIView!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var planPriceLabel: UILabel!

    // Custom

    @IBOutlet weak var customSubscriptionView: UIStackView!
    @IBOutlet weak var serviceNameTextField: UITextField!
    @IBOutlet weak var planNameTextField: UITextField!
    @IBOutlet weak var planPriceTextField: UITextField!

    // Common

    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var cycleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var startDateDatePicker: UIDatePicker!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        writeSubInfo = LocalSubscriptionRepository.plist
        setupView()
    }

    private func setupView() {
        selectPlanView.layer.cornerRadius = Metric.radius
        doneButton.layer.cornerRadius = Metric.radius
        startDateDatePicker.backgroundColor = .white
        startDateDatePicker.layer.cornerRadius = Metric.radius
        startDateDatePicker.layer.masksToBounds = true

        if let defaultSubscription = defaultSubscription {
            containerView.removeArrangedSubview(customSubscriptionView)
            customSubscriptionView.removeFromSuperview()
            selectedPlan = defaultSubscription.plans[0]
            planNameLabel.text = selectedPlan.name
            planPriceLabel.text = "\(selectedPlan.price)원/\(selectedPlan.cycle.rawValue)"
        } else {
            selectPlanContainerView.removeFromSuperview()
            containerView.removeArrangedSubview(selectPlanContainerView)
        }
    }

    // MARK: - Actions

    @IBAction func selctPlanButtonDidTap(_ sender: UIButton) {
        guard let defaultSubscription = defaultSubscription else { return }
        let dropDown = DropDown()
        dropDown.anchorView = selectPlanView
        dropDown.backgroundColor = .white
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.cellHeight = 64
        dropDown.cornerRadius = Metric.radius
        dropDown.dataSource = defaultSubscription.plans.map { $0.name }
        dropDown.cellNib = UINib(nibName: SelectPlanCell.reuseIdentifier, bundle: nil)
        dropDown.customCellConfiguration = { index, _, cell in
            guard let cell = cell as? SelectPlanCell else { return }
            let target = defaultSubscription.plans[index]
            cell.optionLabel.text = target.name
            cell.priceLabel.text = "\(target.price)원/\(target.cycle.rawValue)"
        }
        dropDown.selectionAction = { index, _ in
            let target = defaultSubscription.plans[index]
            self.planNameLabel.text = target.name
            self.planPriceLabel.text = "\(target.price)원/\(target.cycle.rawValue)"
        }
        dropDown.show()
    }

    @IBAction func doneButtonDidTap(_ sender: Any) {
        var subscription: Subscription!
        if let defaultSubscription = defaultSubscription, let selectedPlan = selectedPlan {
            subscription = Subscription(
                serviceName: defaultSubscription.name,
                planName: selectedPlan.name,
                planPrice: selectedPlan.price,
                cycle: selectedPlan.cycle,
                startDate: startDateDatePicker.date,
                endDate: nil,
                imageUrl: defaultSubscription.imageUrl,
                userId: userIdTextField.text
            )
        } else {
            if let serviceName = serviceNameTextField.text,
               let planName = planNameTextField.text,
               let planPrice = planPriceTextField.text {
                subscription = Subscription(
                    serviceName: serviceName,
                    planName: planName,
                    planPrice: Int(planPrice) ?? 0,
                    cycle: Cycle.allCases[cycleSegmentedControl.selectedSegmentIndex],
                    startDate: startDateDatePicker.date,
                    endDate: nil,
                    imageUrl: "",
                    userId: userIdTextField.text
                )
            }

        }
        LocalSubscriptionRepository.save(subscription: subscription)
        navigationController?.popViewController(animated: true)
    }

    // textfield 입력시 keyboard 제어
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

// MARK: - UITextFieldDelegate

extension AddSubscriptionDetailViewController: UITextFieldDelegate {

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
