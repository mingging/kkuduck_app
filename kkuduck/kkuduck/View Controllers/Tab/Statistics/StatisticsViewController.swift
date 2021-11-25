//
//  MetricViewController.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/25.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {

    // container view
    @IBOutlet weak var barChartView: UIView!
    @IBOutlet weak var pieChartView: UIView!

    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // segmentControl Custom
        segmentControl.titleTextAttributes(for: .normal)
        segmentControl.selectedSegmentTintColor = UIColor(hex: "#FDAC53ff")
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }

    // segmentControl

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
