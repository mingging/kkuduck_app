//
//  MetricViewController.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/25.
//

import UIKit
import Charts

class MetricViewController: UIViewController {
//    var monthsValue: [String:Double]?
    var months: [String]!
    var unitsSold: [Double] = []
    var writeSubInfo: NSMutableArray?
    var totalMonth: Int = 0
    

    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        totalSubPrice()
        
        
        
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        months = ["Jun", "Jul", "Aug", "Sep", "Oct", "Nov"]
//        unitsSold = [20000.0, 4000.0, 6000.0, 3000.0, 12000.0, 16000.0]
        //배열을 키와 값으로
//        monthsValue = ["7":20000.0, "8":4000.0, "9":6000.0, "10":3000.0, "11": 12000.0, "12":16000.0]
        
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
        
//        guard let monthsValue = self.monthsValue else { return }
//
//        let months = monthsValue.map { (key, value) in return key }
//        let values = monthsValue.map { (key, value) in return value }
        
        
        setChart(dataPoints: months, values: unitsSold)
        
        
        
    }
    
    
    func totalSubPrice() {
        // 데이터 불러오기
        self.writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))
        
        guard let writeSubInfo = self.writeSubInfo else { return }
        let count = writeSubInfo.count
        
        // 10월의 구독료 뽑아내기
        // startDay에서 10월을 뽑아내기 MM
        let calendar = Calendar.current
        let currentDate = Date()
        print(currentDate)
        func month(from date: Date) -> Int {
            return calendar.dateComponents([.month], from: date).month!
        }
        
        func totalmonth(oneMonth: Int) -> Int{
            for i in 0..<count {
                guard let item = writeSubInfo[i] as? [String:Any] else { return 0 }
                if let price = item["subStartDay"] as? String {
                    print(price)
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy.MM.dd"
                    if let day = formatter.date(from: price) {
                        let month = month(from: day)
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM"
                        print(month) // 월 뽑아냄
                        print("--")
                        // 10월이면 더해서 10월날에 추가, 10월이 아니면 추가하지 않음 -> 10월의 차트
                        if month == oneMonth {
                            if let octPrice = item["planPrice"] as? String {
                                if let pp = Int(octPrice) {
                                    totalMonth += pp
//                                    print(totalOct)
                                }
                            }
                        }
                    }
                }
            }
            return totalMonth
        }
        
        let monthJan = totalmonth(oneMonth: 1)
        print(monthJan)
        print("star")
        
//        unitsSold.append(Double(monthJan))
        
        for i in 6...11 {
            let totalPriceMonth = totalmonth(oneMonth: i)
            unitsSold.append(Double(totalPriceMonth))
        }
        print(unitsSold)
    }
    
    
    
    
    
    // 이번달을 마지막에 나오도록 그 달의 가격의 총 합
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월별 사용 금액")
        
        chartDataSet.colors = [.systemOrange]
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
        chartDataSet.highlightEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        
//        guard let monthsValue = self.monthsValue else { return }
//        let months = monthsValue.map { (key, value) in return key }
//        let intmonths = months.map { (value:String) -> Int in
//            return Int(value)!
//        }
//        let sortIntMonths = intmonths.sorted()
//        print(sortIntMonths)
//        let pp = sortIntMonths.map { (value:Int) -> String in
//            return String(value)
//        }
        
        
        
        
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        
        barChartView.rightAxis.enabled = false
        
//        barChartView.drawGridBackgroundEnabled = false
        
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
//        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
//        barChartView.drawBordersEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.writeSubInfo = NSMutableArray(contentsOfFile: getFileName("writeSubscription.plist"))

        super.viewWillAppear(true)
        self.tableView.reloadData()
        
        setChart(dataPoints: months, values: unitsSold)
        totalSubPrice()
        
        
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


extension MetricViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            print(startDay) // 2021.10.27
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            if let day = formatter.date(from: startDay) {
                print(day) // 2021-10-09 15:00:00 +0000
                let calendar = Calendar.current
                if let componet = calendar.date(byAdding: .day, value: +30, to: day) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy.MM.dd"
                    let strday = formatter.string(from: componet)
                    
//                    cell.textLabel?.text = strday
                    print(strday)
                }
            }
        }
        
        
        
        
        return cell
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "서비스별 사용 금액"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
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

