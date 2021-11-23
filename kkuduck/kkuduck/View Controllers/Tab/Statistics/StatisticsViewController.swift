//
//  MetricViewController.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/25.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {

    var months: [String]!
    var unitsSold: [Double] = []
    var writeSubInfo: NSMutableArray?
    var totalMonth: Int = 0

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        totalSubPrice()

        months = ["Jun", "Jul", "Aug", "Sep", "Oct", "Nov"]

        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray

        setChart(dataPoints: months, values: unitsSold)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        totalSubPrice()
        self.tableView.reloadData()

        setChart(dataPoints: months, values: unitsSold)
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func totalSubPrice() {
        // 데이터 불러오기
        writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))

        guard let writeSubInfo = writeSubInfo else { return }
        let count = writeSubInfo.count

        // 10월의 구독료 뽑아내기
        // startDay에서 10월을 뽑아내기 MM
        let calendar = Calendar.current
        func month(from date: Date) -> Int {
            return calendar.dateComponents([.month], from: date).month!
        }

        func totalmonth(oneMonth: Int) -> Int {
            totalMonth = 0
            for i in 0..<count {
                guard let item = writeSubInfo[i] as? [String:Any] else { return 0 }
                if let subStartDay = item["subStartDay"] as? String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy.MM.dd"
                    if let day = formatter.date(from: subStartDay) {
                        let month = month(from: day)
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM"

                        // 10월이면 더해서 10월날에 추가, 10월이 아니면 추가하지 않음 -> 10월의 차트
                        print(month, oneMonth)
                        if month == oneMonth {
                            if let octPrice = item["planPrice"] as? String {
                                if let pp = Int(octPrice) {
                                    totalMonth += pp
                                }
                            }
                        }
                    }
                }
            }
            return totalMonth
        }

        for i in 6...11 {
            let totalPriceMonth = totalmonth(oneMonth: i)
            unitsSold.append(Double(totalPriceMonth))
        }
    }

    // 이번달을 마지막에 나오도록 그 달의 가격의 총 합
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월별 사용 금액")

        chartDataSet.colors = [.primary!]

        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData

        chartDataSet.highlightEnabled = false
        barChartView.doubleTapToZoomEnabled = false

        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)

        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)

        barChartView.rightAxis.enabled = false

        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
    }

}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let writeSubInfo = self.writeSubInfo {
            return writeSubInfo.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let writeSubInfo = self.writeSubInfo,
              let item = writeSubInfo[indexPath.row] as? [String:Any]
        else { return cell }

        let subName = cell.viewWithTag(1) as? UILabel
        subName?.text = item["planName"] as? String

        let planPrice = cell.viewWithTag(2) as? UILabel
        if let totalPrice = item["planPrice"] as? String {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            planPrice?.text = "\(numberFormatter.string(for: Int(totalPrice))!)원"
        }

        // 달마다 지불되는 구독료를 계산해야 합니다유
        // 이름을 planName의 구독료를 가져와서 이번달까지 낸 것의 총 합
        if let startDay = item["subStartDay"] as? String { // subStartDay -> string 형태로 형변환
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            if let day = formatter.date(from: startDay) {
                let calendar = Calendar.current
                if calendar.date(byAdding: .day, value: +30, to: day) != nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy.MM.dd"
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "서비스별 사용 금액"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }

        let view: UIView = {
            let v = UIView(frame: .infinite)
            v.backgroundColor = .white

            return v
        }()

        header.textLabel?.textColor = .black
        header.textLabel?.isHighlighted = false
        header.backgroundView = view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}
