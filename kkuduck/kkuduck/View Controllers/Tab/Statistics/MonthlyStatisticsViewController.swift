//
//  MonthlyStatisticsViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/11/23.
//

import UIKit
import Charts

class MonthlyStatisticsViewController: UIViewController, ChartViewDelegate {

    // MARK: - Property

    var nowDate = Date()
    var previousMonth: Date?
    var monthArray: [String] = []
    var nowYear: String?

    var unitsSold = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

    var metricData = [[String:Any]]()
    var monthData = [[String:Any]]()

    // MARK: - Outlet

    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        barChart.delegate = self
        setChart()

    }

    override func viewWillAppear(_ animated: Bool) {
        print(CheckServiceChange.shared.isServiceAdd)
        if CheckServiceChange.shared.isServiceAdd {
            setChart()
            CheckServiceChange.shared.isServiceAdd = false
        }
        monthData = metricData
    }

    func getPreviouseSixMonth(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"

        // 현재 날짜 월과 배열에 마지막 값의 월이 같으면 리턴
        if monthArray.last == dateFormatter.string(from: nowDate) {
            return
        }

        for i in 0..<6 {
            previousMonth = Calendar.current.date(byAdding: .month, value: -i, to: date)
            guard let previousMonth = previousMonth else { return }
            monthArray.append(dateFormatter.string(from: previousMonth))
        }

        dateFormatter.dateFormat = "yyyy"
        nowYear = dateFormatter.string(from: date)

        monthArray.reverse()
    }

    // charts setting
    func setChart() {
        metricData = [[String:Any]]()
        barChart.noDataText = "데이터가 없습니다."
        barChart.noDataFont = .systemFont(ofSize: 20)
        barChart.noDataTextColor = .lightGray

        // 현재 날짜 출력
        nowDate = Date()
        print(nowDate)

        // 현재 날짜로부터 6개월 전
        getPreviouseSixMonth(nowDate)

        // 데이터 뿌리기
        var dataEntries: [BarChartDataEntry] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"

        // 현재 날짜와 시작 날짜가 같으면 값 더하기
        for i in 0..<monthArray.count {
            for j in 0..<SubscriptionRepository.shared.subscriptions().count {
                // 년이 같은지 체크
                if nowYear
                    == yearFormatter.string(from: SubscriptionRepository.shared.subscriptions()[j].startDate) {
                    // 월이 같은지 체크 
                    if monthArray[i]
                        == dateFormatter.string(from: SubscriptionRepository.shared.subscriptions()[j].startDate) {
                        unitsSold[i] += Double(SubscriptionRepository.shared.subscriptions()[j].planPrice)
                        let data = [
                            "month": dateFormatter.string(from: SubscriptionRepository.shared.subscriptions()[j].startDate),
                            "serviceName": SubscriptionRepository.shared.subscriptions()[j].serviceName,
                            "planPrice": SubscriptionRepository.shared.subscriptions()[j].planPrice
                        ] as [String : Any]
                        metricData.append(data)
                    }
                }
            }
        }

        print(unitsSold)

        for i in 0..<monthArray.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: unitsSold[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월별 사용 금액")

        chartDataSet.colors = [.orange]

        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.data = chartData

        chartDataSet.highlightEnabled = true
        barChart.doubleTapToZoomEnabled = false

        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: monthArray)

        barChart.xAxis.setLabelCount(monthArray.count, force: false)

        barChart.rightAxis.enabled = false

        barChart.xAxis.drawAxisLineEnabled = false
        barChart.leftAxis.drawAxisLineEnabled = false
        barChart.leftAxis.enabled = false
        barChart.xAxis.drawGridLinesEnabled = false
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        monthData = [[String:Any]]()
        let pos = NSInteger(entry.x)
        for i in 0..<metricData.count {
            let data = metricData[i]
            let month = data["month"]
            if let month = month {
                if monthArray[pos] == month as! String {
                    monthData.append(data)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("호출")
        monthData = [[String:Any]]()
        monthData = metricData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension MonthlyStatisticsViewController:
    UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let data = monthData[indexPath.row]

        let serviceName = cell.viewWithTag(1) as! UILabel
        serviceName.text = data["serviceName"] as? String

        let planPrice = cell.viewWithTag(2) as! UILabel
        guard let price = data["planPrice"] else { return cell }
        planPrice.text = "\(price)원"
        return cell
    }

}
