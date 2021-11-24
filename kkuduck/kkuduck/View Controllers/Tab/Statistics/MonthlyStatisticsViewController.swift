//
//  MonthlyStatisticsViewController.swift
//  kkuduck
//
//  Created by minimani on 2021/11/23.
//

import UIKit
import Charts

class MonthlyStatisticsViewController: UIViewController {

    // MARK: - Property

    var nowDate = Date()
    var previousMonth: Date?
    var monthArray: [String] = []

    var unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

    // MARK: - Outlet

    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setChart()
    }

    func getPreviouseSixMonth(_ date: Date) {
        let dateFormatter = DateFormatter()
        for i in 1...6 {
            previousMonth = Calendar.current.date(byAdding: .month, value: -i, to: date)
            dateFormatter.dateFormat = "LLL"
            guard let previousMonth = previousMonth else { return }
            monthArray.append(dateFormatter.string(from: previousMonth))
        }
    }

    // charts setting
    func setChart() {

        barChart.noDataText = "데이터가 없습니다."
        barChart.noDataFont = .systemFont(ofSize: 20)
        barChart.noDataTextColor = .lightGray

        // 현재 날짜 출력
        nowDate = Date()

        // 현재 날짜로부터 6개월 전
        getPreviouseSixMonth(nowDate)

        // 데이터 뿌리기
        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<monthArray.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: unitsSold[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월별 사용 금액")

        chartDataSet.colors = [.orange]

        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.data = chartData

        chartDataSet.highlightEnabled = false
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
}

extension MonthlyStatisticsViewController:
    UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return cell
    }

}
