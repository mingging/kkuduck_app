//
//  AllStatisticsViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/11/23.
//

import UIKit
import Charts

class AllStatisticsViewController: UIViewController {

    // MARK: - Property

    var testValue = PieChartDataEntry(value: 5000)
    var test2Value = PieChartDataEntry(value: 9900)

    var allChartEntries = [PieChartDataEntry]()

    // MARK: - Outlet

    @IBOutlet weak var pieChart: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        allChartEntries = [testValue, test2Value]

        setChart()
    }

    func setChart() {
        let chartDataSet = PieChartDataSet(entries: allChartEntries, label: "테스트")
        let chartData = PieChartData(dataSet: chartDataSet)

        let colors = [UIColor(hex: "#A2E9FCff"), UIColor(hex: "#F8D495ff")]
        chartDataSet.colors = colors as! [NSUIColor]

        pieChart.data = chartData
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
