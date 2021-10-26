//
//  MetricViewController.swift
//  kkuduck
//
//  Created by Khyeji on 2021/10/25.
//

import UIKit
import Charts

class MetricViewController: UIViewController {
    var months: [String]!
    var unitsSold: [Double]!
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        months = ["Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
        
        setChart(dataPoints: months, values: unitsSold)
        
        

    }
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "서비스별 사용 금액"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    
}
