//
//  IndTeamsViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 11/29/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class IndTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //UI Picker View help from https://www.youtube.com/watch?v=FKuNwHZzJlA
    
    struct AthletesAPI:Decodable {
        let _id: String
        let name: String
        let number: String
        let year: String
        let height: String
        let weight: String
        let bats_throws: String
        let hometown: String
        let high_school: String
        let position: String
        let events: String
        let team: String
        let bio: String
        let __v: Int
    }
    
    struct GamesAPI: Decodable {
        let _id: String
        let team: String
        let year: String
        let date: String
        let status: String
        let home: Bool
        let opponent: String
        let result: String
        let __v: Int
    }
    
    struct GameAPIResults:Decodable {
        let _id: String
        let team: String
        let status: String
        let home:Bool
        let opponent: String
        let result: String
        let results_page: String
        let recap_page: String
        let live_stats_page: String
        let team_name: String
    }
    
    let months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let yearsArray: [String] = ["20-21", "19-20", "18-19", "17-18", "16-17", "15-16", "14-15", "13-14"]


    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabSR: UISegmentedControl!
    @IBOutlet weak var teamLabel: UILabel!
    
    var fullGames: [GameAPIResults]!
    var selectedGame: GameAPIResults!
    var teamName: String!
    var male: Bool!
    var teamID: String!
    var athletes: [AthletesAPI] = []
    var games: [GamesAPI] = []
    var indexClicked: IndexPath!
    var yearSelected: String = "20-21"
    var pickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        var nameString: String = ""
        if male {
            nameString = "Men's "
        }
        else {
            nameString = "Women's "
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        yearTextField.inputView = pickerView
        teamLabel.adjustsFontSizeToFitWidth = true
        teamLabel.text = nameString + teamName
        setupTableView()
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activitySpinner = UIActivityIndicatorView.init(style: .large)
        activitySpinner.startAnimating()
        activitySpinner.center = spinnerView.center
        spinnerView.addSubview(activitySpinner)
        view.addSubview(spinnerView)
        DispatchQueue.global().async {
            self.fetchTeams()
            self.fetchGames()
            DispatchQueue.main.async {
                spinnerView.removeFromSuperview()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tabSR.selectedSegmentIndex == 0) {
            return athletes.count
        }
        else {
            return games.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "athleteCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Helvetica Neue Bold Italic", size: 16)
        if(tabSR.selectedSegmentIndex == 0) {
            let athlete = athletes[indexPath.row]
            if(athlete.number == "") {
                cell.textLabel!.text = athlete.name
            }
            else {
                cell.textLabel!.text = "#" + athlete.number + " " + athlete.name
            }
        }
        else {
            let game = games[indexPath.row]
            cell.textLabel?.text = game.date
//            if game.status == "Final" {
//                cell?.detailTextLabel?.text = game.status + ": " + game.result
//            }
//            else {
//                cell?.detailTextLabel?.text = game.status
//            }
            let label = UILabel.init(frame: CGRect(x:0,y:0,width:130,height:30))
            label.font = UIFont(name: "Helvetica Neue Bold Italic", size: 18)
            label.textAlignment = .right
            label.adjustsFontSizeToFitWidth = true
            if game.opponent.contains("Intrasquad") || game.opponent.contains("Invitational") || game.opponent.contains("Invite") || game.opponent.contains("Pre-Nationals") || game.opponent.contains("Championships") || game.opponent.contains("Regional") || game.opponent.contains("Regionals") || game.opponent.contains("Showdown") || game.opponent.contains("Chance") || game.opponent.contains("Opener") || game.opponent.contains("Triangular") || game.opponent.contains("Open") || game.opponent.contains("Elite") || game.opponent.contains("Qualifier") || game.opponent.contains("Classic") || game.opponent.contains("Meet") || game.opponent.contains("Carnival") || game.opponent.contains("Select") || game.opponent.contains("Twilight") || game.opponent.contains("Multi's") || game.opponent.contains("Dual") || game.opponent.contains("Preview") || game.opponent.contains("Fling") || game.opponent.contains("Champs") {
                label.text = game.opponent
            }
            else if game.home {
                label.text = "v. " + game.opponent
            }
            else {
                label.text = "@ " + game.opponent
            }
            cell.accessoryView = label
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexClicked = indexPath
        if tabSR.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "IndAthleteViewController", sender: self)
        }
        else {
            performSegue(withIdentifier: "IndGameViewController", sender: self)
        }
    }
    
    // help from https://stackoverflow.com/questions/19343519/pass-data-back-to-previous-viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = teamName
        navigationItem.backBarButtonItem = backItem
        if let detailedV = segue.destination as? IndAthleteViewController {
            detailedV._id = athletes[indexClicked.row]._id
            detailedV.name = athletes[indexClicked.row].name
            detailedV.number = athletes[indexClicked.row].number
            detailedV.year = athletes[indexClicked.row].year
            detailedV.height = athletes[indexClicked.row].height
            detailedV.weight = athletes[indexClicked.row].weight
            detailedV.bats_throws = athletes[indexClicked.row].bats_throws
            detailedV.hometown = athletes[indexClicked.row].hometown
            detailedV.high_school = athletes[indexClicked.row].high_school
            detailedV.position = athletes[indexClicked.row].position
            detailedV.events = athletes[indexClicked.row].events
            detailedV.team = athletes[indexClicked.row].team
            let modifiedContent = self.modifyContent(content: athletes[indexClicked.row].bio)
            detailedV.bio = modifiedContent
        }
        
        if let indGameVC = segue.destination as? IndGameViewController {
            fetchIndGame(game: games[indexClicked.row])
            let imageClicked = cacheOpponentImage(game: selectedGame)
            let indGame = Game(_id: selectedGame._id, team: selectedGame.team, status: selectedGame.status, home: selectedGame.home, opponent: selectedGame.opponent, result: selectedGame.result, results_page: selectedGame.results_page, recap_page: selectedGame.recap_page, live_stats_page: selectedGame.live_stats_page, team_name: selectedGame.team_name, image: imageClicked)
                indGameVC.game = indGame
        }
        
    }
    
    func fetchTeams() {
        guard let urlRoster = URL(string: "http://bears-nation-api.herokuapp.com/teams/\(teamID ?? "")/athletes") else {return}
        guard let dataRoster = try? Data(contentsOf: urlRoster) else {return}
        self.athletes = try! JSONDecoder().decode([AthletesAPI].self, from: dataRoster)
    }
    
    func fetchGames() {
        guard let urlGames = URL(string: "http://bears-nation-api.herokuapp.com/teams/\(teamID ?? "")/competitions/\(yearSelected)") else {return}
        guard let dataGames = try? Data(contentsOf: urlGames) else {return}
        self.games = try! JSONDecoder().decode([GamesAPI].self, from: dataGames)
    }
    
    func fetchIndGame(game: GamesAPI) {
        let updatedDate = adjustDate(game: game)
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/competitions?date=\(updatedDate)") else {return}
        guard let dataGames = try? Data(contentsOf: url) else {return}
        self.fullGames = try! JSONDecoder().decode([GameAPIResults].self, from: dataGames)
        for g in fullGames {
            if g._id == game._id {
                selectedGame = g
            }
        }
    }
    
    func cacheOpponentImage(game: GameAPIResults) -> UIImage {
        // get the images for each article
        var image: UIImage!
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/competitions/opponent_logo/" + game._id) else {return UIImage()}
        guard let data = try? Data(contentsOf: url) else {return UIImage()}
        image = UIImage(data: data);
        return image
    }
    
    func modifyContent(content: String) -> String {
            var newContent = ""
            for i in 0..<content.count - 1 {
                
                let startIdx = content.index(content.startIndex, offsetBy: i)
                newContent.append(content[startIdx])
                if content[startIdx].isNewline {
                    newContent.append("\n")
                }
            }
            return newContent
        }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "athleteCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    @IBAction func changedTab(_ sender: Any) {
        tableView.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tabSR.selectedSegmentIndex == 0 {
            return 1
        }
        else {
            return yearsArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if tabSR.selectedSegmentIndex == 0 {
            return "2020-21"
        }
        else {
            return "20" + yearsArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tabSR.selectedSegmentIndex == 0 {
            yearTextField.text = "2020-21"
            yearSelected = "20-21"
        }
        else {
            yearTextField.text = "20" + yearsArray[row]
            yearSelected = yearsArray[row]
            fetchGames()
        }
        yearTextField.resignFirstResponder()
        tableView.reloadData()
    }
    
    func adjustDate(game: GamesAPI) -> String {
        let date = game.date
        var newString = ""
        let startTrim = date.index(date.startIndex, offsetBy: 5)
        let endTrim = date.index(date.endIndex, offsetBy: -9)
        let range1 = startTrim..<endTrim
        let newSub = date[range1]
        let monthString = String(newSub)
        
        for month in months {
            if month == monthString {
                var index = months.firstIndex(of: month) ?? 0
                index += 1
                newString += String(index)
            }
        }
        newString += "/"
        
        let startTrim2 = date.index(date.endIndex, offsetBy: -8)
        let endTrim2 = date.index(date.endIndex, offsetBy: -6)
        let range2 = startTrim2..<endTrim2
        let newSub2 = date[range2]
        let dayString = String(newSub2)
        
        newString += dayString + "/"
        

        let start = date.index(date.endIndex, offsetBy: -4)
        let end = date.index(date.endIndex, offsetBy: 0)
        let range = start..<end
        let sub = date[range]
        let yearString = String(sub)
        
        newString += yearString
        return newString
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
