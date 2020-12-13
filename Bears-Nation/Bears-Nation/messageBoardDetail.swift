//
//  messageBoardDetail.swift
//  Bears-Nation
//
//  Created by Chris Macdonald on 11/29/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class messageBoardDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var MySwitch: UISwitch!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    var first:Bool = true
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theCell") as! tableViewHandler
        if(indexPath.row == 0){
            cell.subjectDetail.text = subject
            cell.userDetail.text = "User: \(allData[index].name)"
            cell.messageDetail.text = allData[index].message
        } else{
            if(Order){
                cell.subjectDetail.text = "Re: " + subject
                cell.userDetail.text = "User: \(responses[(indexPath.row - 1)].name)"
                cell.messageDetail.text = responses[(indexPath.row - 1)].message
            } else{
                let index = responses.count - indexPath.row
                cell.subjectDetail.text = "Re: " + subject
                cell.userDetail.text = "User: \(responses[index].name)"
                cell.messageDetail.text = responses[index].message
            }
            

        }
        return cell
    }
    
    
    var subject: String = ""
    var index: Int = 0
    var ID: String = ""
    var Order: Bool = true
    
    
    
    var allData:[MessageBoard.posts] = []
    
    
    var responses:[MessageBoard.response] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        fetchMessages()
    }
    
    
    @IBAction func order(_ sender: UISwitch) {
        if(sender.isOn){
            Order = true
            tableView.reloadData()
        } else{
            Order = false
            tableView.reloadData()
        }
    }
    

    
    func fetchMessages(){
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/messages") else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        self.allData = try! JSONDecoder().decode([MessageBoard.posts].self, from: data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchMessages()
        responses = allData[index].replies
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var replyPoster = replyPost()
        replyPoster.id = self.ID
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! replyPost
        controller.id = ID
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
