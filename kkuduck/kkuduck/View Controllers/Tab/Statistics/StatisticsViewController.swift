//
//  MetricViewController.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/25.
//

import UIKit

final class StatisticsViewController: UIViewController {

    private enum Font {
        static let segmentedControl = UIFont(name: "GmarketSansMedium", size: 12)!
    }

    // MARK: - Outlets

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var barChartView: UIView!
    @IBOutlet weak var pieChartView: UIView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        let attributes = [NSAttributedString.Key.font: Font.segmentedControl]
        segmentedControl.setTitleTextAttributes(attributes, for: .normal)
    }

    // MARK: - Actions

    @IBAction func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            pieChartView.alpha = 1.0
            barChartView.alpha = 0.0
        } else {
            pieChartView.alpha = 0.0
            barChartView.alpha = 1.0
        }
    }

}
