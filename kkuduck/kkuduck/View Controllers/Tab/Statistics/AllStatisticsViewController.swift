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

    var allChartEntries = [PieChartDataEntry]()

    var metricData = [[String:Any]]()

    // MARK: - Outlet

    @IBOutlet weak var pieChart: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

       // allChartEntries = [testValue, test2Value]
        setChart()
    }

    override func viewWillAppear(_ animated: Bool) {
        print( "all \(CheckServiceChange.shared.isServiceAdd)")
        if CheckServiceChange.shared.isServiceAdd {
            setChart()

            CheckServiceChange.shared.isServiceAdd = false
        }
    }

    func setChart() {
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
                colors.append(.random)
            }
        }

        let chartDataSet = PieChartDataSet(entries: allChartEntries, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = colors

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
