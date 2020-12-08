//
//  GamesViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 12/8/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {

    var dateBox1: UIView!
    var dateBox2: UIView!
    var dateBox3: UIView!
    var dateBox4: UIView!
    var dateBox5: UIView!

    let monthConv: [String: String] = [
        "01": "JAN",
        "02": "FEB",
        "03": "MAR",
        "04": "APR",
        "05": "MAY",
        "06": "JUN",
        "07": "JUL",
        "08": "AUG",
        "09": "SEP",
        "10": "OCT",
        "11": "NOV",
        "12": "DEC"
    ]
    
    func getDateVals(date: Date) -> [String] {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        let dateVals = formattedDate.components(separatedBy: "-")
        return dateVals
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var calendar = Calendar.current
        // get current date
        let date1 = Date()
        let dateVals1 = getDateVals(date: date1)
        
        // create date boxes
        let dateBoxSize: CGFloat = view.frame.width / 6.25
        let gapSize: CGFloat = (view.frame.width - 40 - (5*dateBoxSize)) / 4.0
        let monthLabelWidth = dateBoxSize / 1.25
        let monthLabelHeight = dateBoxSize / 3.0
        let dateLabelWidth = dateBoxSize / 2.0
        
        dateBox1 = UIView(frame: CGRect(x: 20 + 0 * (dateBoxSize + gapSize), y: 103, width: dateBoxSize, height: dateBoxSize))
        dateBox1.backgroundColor = UIColor(named: "WashURed")
        let date1MonthLabel = UILabel(frame: CGRect(x: 6, y: 8, width: monthLabelWidth, height: monthLabelHeight))
        date1MonthLabel.text = monthConv[dateVals1[1]]
        date1MonthLabel.textAlignment = .center
        date1MonthLabel.textColor = .white
        dateBox1.addSubview(date1MonthLabel)
        let date1DateLabel = UILabel(frame: CGRect(x: 0, y: date1MonthLabel.frame.origin.y + date1MonthLabel.frame.height + 2, width: dateLabelWidth, height: monthLabelHeight))
        date1DateLabel.center.x = date1MonthLabel.center.x
        date1DateLabel.text = dateVals1[2]
        date1DateLabel.textAlignment = .center
        date1DateLabel.textColor = .white
        dateBox1.addSubview(date1DateLabel)
        view.addSubview(dateBox1)
        
        // get date
        let date2 = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: date1))!
        let dateVals2 = getDateVals(date: date2)
        
        dateBox2 = UIView(frame: CGRect(x: 20 + 1 * (dateBoxSize + gapSize), y: 103, width: dateBoxSize, height: dateBoxSize))
        dateBox2.backgroundColor = .systemGray2
        let date2MonthLabel = UILabel(frame: CGRect(x: 6, y: 8, width: monthLabelWidth, height: monthLabelHeight))
        date2MonthLabel.text = monthConv[dateVals2[1]]
        date2MonthLabel.textAlignment = .center
        date2MonthLabel.textColor = .white
        dateBox2.addSubview(date2MonthLabel)
        let date2DateLabel = UILabel(frame: CGRect(x: 0, y: date2MonthLabel.frame.origin.y + date2MonthLabel.frame.height + 2, width: dateLabelWidth, height: monthLabelHeight))
        date2DateLabel.center.x = date2MonthLabel.center.x
        date2DateLabel.text = dateVals2[2]
        date2DateLabel.textAlignment = .center
        date2DateLabel.textColor = .white
        dateBox2.addSubview(date2DateLabel)
        view.addSubview(dateBox2)
        
        // get date
        let date3 = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: date2))!
        let dateVals3 = getDateVals(date: date3)
        print(dateVals3)
        
        dateBox3 = UIView(frame: CGRect(x: 20 + 2 * (dateBoxSize + gapSize), y: 103, width: dateBoxSize, height: dateBoxSize))
        dateBox3.backgroundColor = .systemGray2
        let date3MonthLabel = UILabel(frame: CGRect(x: 6, y: 8, width: monthLabelWidth, height: monthLabelHeight))
        date3MonthLabel.text = monthConv[dateVals3[1]]
        date3MonthLabel.textAlignment = .center
        date3MonthLabel.textColor = .white
        dateBox3.addSubview(date3MonthLabel)
        let date3DateLabel = UILabel(frame: CGRect(x: 0, y: date3MonthLabel.frame.origin.y + date3MonthLabel.frame.height + 2, width: dateLabelWidth, height: monthLabelHeight))
        date3DateLabel.center.x = date3MonthLabel.center.x
        date3DateLabel.text = dateVals3[2]
        date3DateLabel.textAlignment = .center
        date3DateLabel.textColor = .white
        dateBox3.addSubview(date3DateLabel)
        view.addSubview(dateBox3)
        
        // get date
        let date4 = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: date3))!
        let dateVals4 = getDateVals(date: date4)
        
        dateBox4 = UIView(frame: CGRect(x: 20 + 3 * (dateBoxSize + gapSize), y: 103, width: dateBoxSize, height: dateBoxSize))
        dateBox4.backgroundColor = .systemGray2
        let date4MonthLabel = UILabel(frame: CGRect(x: 6, y: 8, width: monthLabelWidth, height: monthLabelHeight))
        date4MonthLabel.text = monthConv[dateVals4[1]]
        date4MonthLabel.textAlignment = .center
        date4MonthLabel.textColor = .white
        dateBox4.addSubview(date3MonthLabel)
        let date4DateLabel = UILabel(frame: CGRect(x: 0, y: date4MonthLabel.frame.origin.y + date4MonthLabel.frame.height + 2, width: dateLabelWidth, height: monthLabelHeight))
        date4DateLabel.center.x = date4MonthLabel.center.x
        date4DateLabel.text = dateVals4[2]
        date4DateLabel.textAlignment = .center
        date4DateLabel.textColor = .white
        dateBox4.addSubview(date4DateLabel)
        view.addSubview(dateBox4)
        
        dateBox5 = UIView(frame: CGRect(x: 20 + 4 * (dateBoxSize + gapSize), y: 103, width: dateBoxSize, height: dateBoxSize))
        dateBox5.backgroundColor = .systemGray2
        view.addSubview(dateBox5)
        
        
        print("here")
        
        
        // Do any additional setup after loading the view.
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
