//
//  AddServiceDetailViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/10/26.
//

import UIKit
import DropDown

final class AddServiceDetailViewController: UIViewController {

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

    @IBOutlet weak var customPlanContainerView: UIStackView!
    @IBOutlet weak var planNameTextField: UITextField!
    @IBOutlet weak var planPriceTextField: UITextField!

    // Common

    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var cycleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var startDateDatePicker: UIDatePicker!
    @IBOutlet weak var serviceIdentifierTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        setupView()
    }

    private func setupView() {
        selectPlanView.layer.cornerRadius = 5
        doneButton.layer.cornerRadius = 5

        if let defaultSubscription = defaultSubscription {
            containerView.removeArrangedSubview(customPlanContainerView)
            customPlanContainerView.removeFromSuperview()
            selectedPlan = defaultSubscription.plans[0]
            planNameLabel.text = selectedPlan.name
            planPriceLabel.text = "\(selectedPlan.price)원/\(selectedPlan.cycle)"
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
        dropDown.cornerRadius = 5
        dropDown.dataSource = defaultSubscription.plans.map { $0.name }
        dropDown.cellNib = UINib(nibName: SelectPlanCell.reuseIdentifier, bundle: nil)
        dropDown.customCellConfiguration = { index, _, cell in
            guard let cell = cell as? SelectPlanCell else { return }
            let target = defaultSubscription.plans[index]
            cell.optionLabel.text = target.name
            cell.priceLabel.text = "\(target.price)원/\(target.cycle)"
        }
        dropDown.selectionAction = { index, _ in
            let target = defaultSubscription.plans[index]
            self.planNameLabel.text = target.name
            self.planPriceLabel.text = "\(target.price)원/\(target.cycle)"
        }
        dropDown.show()
    }

    @IBAction func doneButtonDidTap(_ sender: Any) {
        var subscription: [String: Any] = [:]

        subscription["subserviceID"] = serviceIdentifierTextField.text
        subscription["subStartDay"] = CustomDateFormatter.string(from: startDateDatePicker.date)

        if let service = defaultSubscription,
           let selectedPlan = selectedPlan {
            subscription["planName"] = service.name
            subscription["planPrice"] = selectedPlan.price
            subscription["cycle"] = selectedPlan.cycle
            subscription["img"] = service.imageUrl
        } else {
            subscription["img"] = ""
            subscription["planPrice"] = Int(planPriceTextField.text ?? "0") ?? 0
            subscription["planName"] = planNameTextField.text
            let cycle = cycleSegmentedControl.titleForSegment(at: cycleSegmentedControl.selectedSegmentIndex)
            subscription["cycle"] = cycle
        }

        guard let writeSubInfo = writeSubInfo else { return }
        writeSubInfo.add(subscription)
        writeSubInfo.write(toFile: getFileName("writeSubscription.plist"), atomically: true)

        navigationController?.popViewController(animated: true)
    }

    // textfield 입력시 keyboard 제어
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

// MARK: - UITextFieldDelegate

extension AddServiceDetailViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
