//
//  TeamsViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 11/27/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class TeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct TeamsAPI:Decodable {
        let mens: Bool
        let _id: String
        let sport: String
        let __v: Int
    }
    
    var indexClicked: IndexPath!
    var teams: [TeamsAPI] = []
    var combined: [[TeamsAPI]] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return combined.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Men's Sports"
        }
        else {
            return "Women's Sports"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combined[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        let team = combined[indexPath.section][indexPath.row]
        cell.textLabel!.text = team.sport
        if team.sport == "Track & Field" {
            cell.imageView!.image = UIImage(named: "Podium")
        }
        else if team.sport == "Baseball" || team.sport == "Softball" {
            cell.imageView!.image = UIImage(named: "BBSB")
        }
        else if team.sport == "Basketball" {
            cell.imageView!.image = UIImage(named: "BBall")
        }
        else if team.sport == "Cross Country" {
            cell.imageView!.image = UIImage(named: "Timer")
        }
        else if team.sport == "Football" {
            cell.imageView!.image = UIImage(named: "Football")
        }
        else if team.sport == "Soccer" {
            cell.imageView!.image = UIImage(named: "Soccer")
        }
        else if team.sport == "Swimming and Diving" || team.sport == "Swimming & Diving" {
            cell.imageView!.image = UIImage(named: "Swim")
        }
        else if team.sport == "Tennis" {
            cell.imageView!.image = UIImage(named: "Tennis")
        }
        else if team.sport == "Golf" {
            cell.imageView!.image = UIImage(named: "Golf")
        }
        else {
            cell.imageView!.image = UIImage(named: "Volleyball")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexClicked = indexPath
        performSegue(withIdentifier: "IndTeamsViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Teams"
        navigationItem.backBarButtonItem = backItem
        let detailedV = segue.destination as? IndTeamsViewController
        detailedV?.teamName = combined[indexClicked.section][indexClicked.row].sport
        detailedV?.teamID = combined[indexClicked.section][indexClicked.row]._id
        if indexClicked.section == 0 {
            detailedV?.male = true
        }
        else {
            detailedV?.male = false
        }
    }
    
    func fetchTeams() {
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/teams") else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        self.teams = try! JSONDecoder().decode([TeamsAPI].self, from: data)
        setupSections()
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "teamCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    func setupSections() {
        var mens: [TeamsAPI] = []
        var womens: [TeamsAPI] = []
        for t in teams {
            if t.mens {
                mens.append(t)
            }
            else {
                womens.append(t)
            }
        }
        combined.append(mens)
        combined.append(womens)
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
