//
//  MonthlyStatisticsViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/11/23.
//

import UIKit
import Charts

final class MonthlyStatisticsViewController: UIViewController {

    private enum Font {
        static let chartLabel = UIFont(name: "GmarketSansBold", size: 15)!
    }

    // MARK: - Properties

    var monthArray: [String] = []
    var months: [Date] = []

    var unitsSold = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

    var metricData = [[String: Any]]()
    var monthData = [[String: Any]]()

    private lazy var monthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM" // ex) 12월이면 Dec
        return formatter
    }()

    // MARK: - Outlets

    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        setup(barChartView: barChart)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setChart()
        chartValueNothingSelected(barChart)
    }

    // MARK: -

    private func setup(barChartView chartView: BarChartView) {
        chartView.delegate = self

        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false

        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false

        chartView.rightAxis.enabled = false

        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.enabled = false

        chartView.noDataFont = Font.chartLabel
        chartView.noDataTextColor = .label
        chartView.noDataText = "데이터가 없습니다."
    }

    private func setChart() {
        metricData = [[String: Any]]()
        unitsSold = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        // 현재 날짜로부터 6개월 전
        let today = Date()
        getPreviouseSixMonth(today)

        // 데이터 뿌리기
        var dataEntries: [BarChartDataEntry] = []
        (0..<months.count).forEach { index in
            let month = months[index]
            SubscriptionRepository.shared.subscriptions().forEach { subscription in
                let calendar = Calendar.current
                let startDateComponent = calendar.dateComponents([.year, .month], from: subscription.startDate)
                let monthComponent = calendar.dateComponents([.year, .month], from: month)
                if monthComponent >= startDateComponent {
                    unitsSold[index] += Double(subscription.planPrice)
                    let data = [
                        "month": monthArray[index],
                        "serviceName": subscription.serviceName,
                        "planPrice": subscription.planPrice
                    ] as [String: Any]
                    metricData.append(data)
                }
            }
        }

        for i in 0..<monthArray.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: unitsSold[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월별 사용 금액")
        chartDataSet.colors = [.primary!]
        chartDataSet.highlightEnabled = true

        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: monthArray)
        barChart.xAxis.setLabelCount(monthArray.count, force: false)
        barChart.data = chartData
    }

    private func getPreviouseSixMonth(_ date: Date) {
        months = []
        monthArray = []
        (0..<6).forEach { index in
            let previousMonth = Calendar.current.date(byAdding: .month, value: -index, to: date)
            guard let previousMonth = previousMonth else { return }
            months.append(previousMonth)
            monthArray.append(monthDateFormatter.string(from: previousMonth))
        }
        months.reverse()
        monthArray.reverse()
    }

}

// MARK: - ChartViewDelegate

extension MonthlyStatisticsViewController: ChartViewDelegate {

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {let selectedIndex = Int(entry.x)
        let selectedMonth = monthArray[selectedIndex]
        let filteredMonthData: [[String: Any]] = metricData.filter {
            let month = $0["month"] as! String
            return month == selectedMonth
        }
        monthData = filteredMonthData

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        // 서비스별 총 이용금액
        var totalPrices = [String: Int]()
        let services = Set(metricData.map { $0["serviceName"] as! String })
        services.forEach { serviceName in
            totalPrices[serviceName] = metricData
                .filter { serviceName == $0["serviceName"] as! String }
                .map { $0["planPrice"] as! Int }
                .reduce(0, +)
        }
        monthData = totalPrices.map { ["serviceName": $0.key, "planPrice": $0.value] as [String: Any] }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MonthlyStatisticsViewController:
    UITableViewDelegate, UITableViewDataSource {

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
