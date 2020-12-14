//
//  IndTeamsViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 11/29/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class IndTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabSR: UISegmentedControl!
    @IBOutlet weak var teamLabel: UILabel!
    
    var teamName: String!
    var male: Bool!
    var teamID: String!
    var athletes: [AthletesAPI] = []
    var games: [GamesAPI] = []
    var indexClicked: IndexPath!
    var yearSelected: String = "19-20"
    override func viewDidLoad() {
        super.viewDidLoad()
        var nameString: String = ""
        if male {
            nameString = "Men's "
        }
        else {
            nameString = "Women's "
        }
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
        cell.textLabel?.font = UIFont(name: "Times New Roman", size: 16)
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
            label.font = UIFont(name: "Times New Roman", size: 18)
            label.textAlignment = .right
            label.adjustsFontSizeToFitWidth = true
            if game.opponent.contains("Intrasquad") || game.opponent.contains("Invitational") || game.opponent.contains("Invite") || game.opponent.contains("Pre-Nationals") || game.opponent.contains("Championships") || game.opponent.contains("Regional") || game.opponent.contains("Regionals") || game.opponent.contains("Showdown") || game.opponent.contains("Chance") || game.opponent.contains("Opener") || game.opponent.contains("Triangular") || game.opponent.contains("Open") || game.opponent.contains("Elite") || game.opponent.contains("Qualifier") || game.opponent.contains("Classic") || game.opponent.contains("Meet") || game.opponent.contains("Carnival") || game.opponent.contains("Select") || game.opponent.contains("Twilight") || game.opponent.contains("Multi's") || game.opponent.contains("Dual") || game.opponent.contains("Preview") || game.opponent.contains("Fling") {
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
        performSegue(withIdentifier: "IndAthleteViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = teamName
        navigationItem.backBarButtonItem = backItem
        let detailedV = segue.destination as? IndAthleteViewController
        detailedV?._id = athletes[indexClicked.row]._id
        detailedV?.name = athletes[indexClicked.row].name
        detailedV?.number = athletes[indexClicked.row].number
        detailedV?.year = athletes[indexClicked.row].year
        detailedV?.height = athletes[indexClicked.row].height
        detailedV?.weight = athletes[indexClicked.row].weight
        detailedV?.bats_throws = athletes[indexClicked.row].bats_throws
        detailedV?.hometown = athletes[indexClicked.row].hometown
        detailedV?.high_school = athletes[indexClicked.row].high_school
        detailedV?.position = athletes[indexClicked.row].position
        detailedV?.events = athletes[indexClicked.row].events
        detailedV?.team = athletes[indexClicked.row].team
        let modifiedContent = self.modifyContent(content: athletes[indexClicked.row].bio)
        detailedV?.bio = modifiedContent
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
