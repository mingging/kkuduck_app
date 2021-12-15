//
//  AllStatisticsViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/11/23.
//

import UIKit
import Charts

final class AllStatisticsViewController: UIViewController {

    private enum Font {
        static let chartLabel = UIFont(name: "GmarketSansBold", size: 15)!
    }

    // MARK: - Properties

    var allChartEntries = [PieChartDataEntry]()

    var metricData = [[String: Any]]()

    // MARK: - Outlets

    @IBOutlet weak var pieChart: PieChartView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup(pieChartView: pieChart)
        setChart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if CheckServiceChange.shared.isServiceAdd {
            setChart()
            CheckServiceChange.shared.isServiceAdd = false
        }
    }

    private func setup(pieChartView chartView: PieChartView) {
        chartView.entryLabelFont = Font.chartLabel
        chartView.entryLabelColor = .label
        chartView.legend.enabled = false
    }

    private func setChart() {
        metricData = [[String:Any]]()
        allChartEntries = [PieChartDataEntry]()
        pieChart.noDataText = "데이터가 없습니다."
        for i in 0..<SubscriptionRepository.shared.subscriptions().count {
            let data = [
                "serviceName": SubscriptionRepository.shared.subscriptions()[i].serviceName,
                "planPrice": SubscriptionRepository.shared.subscriptions()[i].planPrice
            ] as [String : Any]
            metricData.append(data)
        }

        var totalPrice = 0
        for i in 0..<metricData.count {
            if !metricData[i].isEmpty {
                totalPrice = metricData[i]["planPrice"] as! Int
                for j in 0..<metricData.count {
                    if i != j
                        && !metricData[j].isEmpty {
                        if (metricData[i]["serviceName"] as! String == metricData[j]["serviceName"] as! String) {
                            totalPrice += metricData[j]["planPrice"] as! Int
                            metricData[j] = [:]
                        }
                    }
                }
                metricData[i]["planPrice"] = totalPrice
            }
        }

        var colors = [UIColor]()
        for i in 0..<metricData.count {
            if !metricData[i].isEmpty {
                allChartEntries.append(
                    PieChartDataEntry(
                        value: Double(metricData[i]["planPrice"] as! Int),
                        label: metricData[i]["serviceName"] as? String
                    )
                )
                let alpha = 1 - CGFloat(i) / CGFloat(metricData.count)
                let color = UIColor.primary?.withAlphaComponent(alpha)
                colors.append(color ?? .random)
            }
        }

        let chartDataSet = PieChartDataSet(entries: allChartEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueTextColor(.label)
        chartDataSet.colors = colors

        pieChart.data = chartData
    }

}
