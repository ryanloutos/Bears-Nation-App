//
//  GamesViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 12/8/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {

    struct Games:Decodable {
        let _id: String
        let team: String
        let status: String
        let home:Bool
        let opponent: String
        let result: String
    }
    
    let dummyGamesDec9 = [
        Games(_id: "1", team: "Men's Soccer", status: "Final", home: true, opponent: "Chicago", result: "L, 1-0"),
        Games(_id: "2", team: "Women's Volleyball", status: "Final", home: true, opponent: "Chicago", result: "W, 6-5")
    ]
    
    @IBOutlet weak var dateButton1: UIButton!
    @IBOutlet weak var dateButton2: UIButton!
    @IBOutlet weak var dateButton3: UIButton!
    @IBOutlet weak var dateButton4: UIButton!
    @IBOutlet weak var calButton: UIButton!
    
    @IBOutlet weak var currentDateLabel: UILabel!
    
    var currentDate: Date!
    

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
    
    let monthConvFull: [String: String] = [
        "01": "January",
        "02": "February",
        "03": "March",
        "04": "April",
        "05": "May",
        "06": "June",
        "07": "July",
        "08": "August",
        "09": "September",
        "10": "October",
        "11": "November",
        "12": "December"
    ]
    
    
    func getDateVals(date: Date) -> [String] {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        let dateVals = formattedDate.components(separatedBy: "-")
        return dateVals
    }
    
    func updateDates(date: Date) {
        let calendar = Calendar.current
        var dates: [[String]] = []
        
        var curDate = date
        
        for _ in 0..<4 {
            // get date vals for each date
            dates.append(getDateVals(date: curDate))
            curDate = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: curDate))!
        }
        
        dateButton1.setTitle("\(String(describing: monthConv[dates[0][1]]!)) \(dates[0][2])", for: .normal)
        dateButton2.setTitle("\(String(describing: monthConv[dates[1][1]]!)) \(dates[1][2])", for: .normal)
        dateButton3.setTitle("\(String(describing: monthConv[dates[2][1]]!)) \(dates[2][2])", for: .normal)
        dateButton4.setTitle("\(String(describing: monthConv[dates[3][1]]!)) \(dates[3][2])", for: .normal)
        
        // set font
        dateButton1.titleLabel?.font = UIFont(name: "Gill Sans", size: 23)
        dateButton2.titleLabel?.font = UIFont(name: "Gill Sans", size: 23)
        dateButton3.titleLabel?.font = UIFont(name: "Gill Sans", size: 23)
        dateButton4.titleLabel?.font = UIFont(name: "Gill Sans", size: 23)
        
        // set alignment
        dateButton1.titleLabel?.textAlignment = .center
        dateButton2.titleLabel?.textAlignment = .center
        dateButton3.titleLabel?.textAlignment = .center
        dateButton4.titleLabel?.textAlignment = .center
    }
    
    func dropLeadingZero(dateVal: String) -> String {
        
        if dateVal[dateVal.startIndex] == "0" {
            return String(dateVal.dropFirst())
        }
        return dateVal
    }
    
    func updateSchedule() {
        let curDateVals = getDateVals(date: currentDate)
        currentDateLabel.text = "\(String(describing: monthConvFull[curDateVals[1]]!)) \(dropLeadingZero(dateVal: curDateVals[2])), \(curDateVals[0])"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentDate = Date()
        updateDates(date: currentDate)
        updateSchedule()
        
        
        
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
