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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabSR: UISegmentedControl!
    @IBOutlet weak var teamLabel: UILabel!
    
    var teamName: String!
    var male: Bool!
    var teamID: String!
    var athletes: [AthletesAPI] = []
    var indexClicked: IndexPath!
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
            DispatchQueue.main.async {
                spinnerView.removeFromSuperview()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        athletes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "athleteCell", for: indexPath)
        let athlete = athletes[indexPath.row]
        if(athlete.number == "") {
            cell.textLabel!.text = athlete.name
        }
        else {
            cell.textLabel!.text = "#" + athlete.number + " " + athlete.name
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
        detailedV?.bio = athletes[indexClicked.row].bio
    }
    
    func fetchTeams() {
        guard let url = URL(string: "http://bears-nation-api.herokuapp.com/teams/\(teamID ?? "")/athletes") else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        self.athletes = try! JSONDecoder().decode([AthletesAPI].self, from: data)
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "athleteCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
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
