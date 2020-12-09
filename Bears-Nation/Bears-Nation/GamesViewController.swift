//
//  GamesViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 12/8/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let calendar = Calendar.current

    struct APIResults:Decodable {
        let _id: String
        let team: String
        let status: String
        let home:Bool
        let opponent: String
        let result: String
    }
    
    let dummyGames1 = [
        APIResults(_id: "1", team: "Men's Soccer", status: "Final", home: true, opponent: "Chicago", result: "L, 1-0"),
        APIResults(_id: "2", team: "Women's Volleyball", status: "Final", home: false, opponent: "Emory", result: "W, 6-5")
    ]
    
    let dummyGames2 = [
        APIResults(_id: "3", team: "Men's Basketball", status: "Final", home: true, opponent: "Carnegie Mellon", result: "L, 76-54"),
        APIResults(_id: "4", team: "Women's Soccer", status: "Final", home: true, opponent: "Wheaton", result: "W, 3-0"),
        APIResults(_id: "5", team: "Softball", status: "Final", home: false, opponent: "NYU", result: "L, 4-1")
    ]
    
    let dummyGames3 = [
        APIResults(_id: "5", team: "Men's Baseball", status: "Final", home: true, opponent: "Brandeis", result: "W, 5-2")
    ]
    
    @IBOutlet weak var dateButton1: UIButton!
    @IBOutlet weak var dateButton2: UIButton!
    @IBOutlet weak var dateButton3: UIButton!
    @IBOutlet weak var dateButton4: UIButton!
    @IBOutlet weak var calButton: UIButton!
    
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentDate: Date!
    var firstDate: Date!
    
    var games: [APIResults] = []

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

    @IBAction func onDateButton1(_ sender: Any) {
        setAllDateButtonsGrey()
        dateButton1.backgroundColor = UIColor(named: "WashURed")
        updateCurrentDate(daysAfterFirst: 0)
        updateSchedule()
    }
    
    @IBAction func onDateButton2(_ sender: Any) {
        setAllDateButtonsGrey()
        dateButton2.backgroundColor = UIColor(named: "WashURed")
        updateCurrentDate(daysAfterFirst: 1)
        updateSchedule()
    }
    
    @IBAction func onDateButton3(_ sender: Any) {
        setAllDateButtonsGrey()
        dateButton3.backgroundColor = UIColor(named: "WashURed")
        updateCurrentDate(daysAfterFirst: 2)
        updateSchedule()
    }
    
    @IBAction func onDateButton4(_ sender: Any) {
        setAllDateButtonsGrey()
        dateButton4.backgroundColor = UIColor(named: "WashURed")
        updateCurrentDate(daysAfterFirst: 3)
        updateSchedule()
    }
    
    func updateCurrentDate(daysAfterFirst: Int) {
        currentDate = calendar.date(byAdding: .day, value: daysAfterFirst, to: calendar.startOfDay(for: firstDate))!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // from Michael Ginn
        cell.contentView.subviews.forEach {$0.removeFromSuperview()}
        
        
        // header
        let header = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height / 4))
        header.backgroundColor = UIColor(named: "WashURed")
        
        let teamLabel = UILabel(frame: CGRect(x: 5, y: 0, width: cell.frame.width / 2, height: header.frame.height))
        teamLabel.text = games[indexPath.row].team
        teamLabel.textAlignment = .left
        teamLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        teamLabel.textColor = .white
        
        let resultLabel = UILabel(frame: CGRect(x: cell.frame.width / 2 + 5, y: 0, width: cell.frame.width / 2 - 10, height: header.frame.height))
        resultLabel.text = "\(games[indexPath.row].status), \(games[indexPath.row].result)"
        resultLabel.textAlignment = .right
        resultLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        resultLabel.textColor = .white
        
        header.addSubview(teamLabel)
        header.addSubview(resultLabel)
                
        
        // body
        let body = UIView(frame: CGRect(x: 0, y: header.frame.height, width: cell.frame.width, height: cell.frame.height / 2))
        body.backgroundColor = .systemGray2

        let opponentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: body.frame.height))
        opponentLabel.center.y = body.center.y - header.frame.height
        if games[indexPath.row].home {
            opponentLabel.text = "vs \(games[indexPath.row].opponent)"
        }
        else {
            opponentLabel.text = "at \(games[indexPath.row].opponent)"
        }
        opponentLabel.textAlignment = .center
        opponentLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        opponentLabel.textColor = .white

        body.addSubview(opponentLabel)
        
        
        cell.addSubview(header)
        cell.addSubview(body)
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    func getDateVals(date: Date) -> [String] {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        let dateVals = formattedDate.components(separatedBy: "-")
        return dateVals
    }
    
    func updateDates(date: Date) {
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
        dateButton1.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 23)
        dateButton2.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 23)
        dateButton3.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 23)
        dateButton4.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 23)
        
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
    
    func setAllDateButtonsGrey() {
        dateButton1.backgroundColor = .systemGray2
        dateButton2.backgroundColor = .systemGray2
        dateButton3.backgroundColor = .systemGray2
        dateButton4.backgroundColor = .systemGray2
    }
    
    func updateSchedule() {
        let curDateVals = getDateVals(date: currentDate)
        currentDateLabel.text = "\(String(describing: monthConvFull[curDateVals[1]]!)) \(dropLeadingZero(dateVal: curDateVals[2])), \(curDateVals[0])"
        fetchGames()
    }
    
    func fetchGames() {
        let curDateVal = getDateVals(date: currentDate)[2]
        if curDateVal == "09" {
            games = dummyGames1
        }
        else if curDateVal == "10" {
            games = dummyGames2
        }
        else {
            games = dummyGames3
        }
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentDate = Date()
        firstDate = Date()
        updateDates(date: currentDate)
        setupCollectionView()
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
