//
//  MessageBoard.swift
//  Bears-Nation
//
//  Created by Chris Macdonald on 11/27/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class MessageBoard: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let cell = tableView.dequeueReusableCell(withIdentifier: "theCell") as! tableViewHandler
        cell.repliesMain.text = "Replies: \(getData[indexPath.row].replies.count)"
        cell.subjectMain.text = getData[indexPath.row].subject
        return cell
    }
 

    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchMessages()
        tableView.reloadData()
    }
    
    struct posts: Decodable {
        let _id: String
        let name: String
        let subject: String
        let message: String
        let replies: [response]
    }
    struct response: Decodable {
        let name: String
        let message: String
    }
    
    var getData: [posts] = []
    var indexClicked: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("going to delete data")
        self.fetchMessages()
//        for x in getData{
//            deleteMessages(ID: x._id)
//        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    
    
    func fetchMessages(){
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/messages") else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        self.getData = try! JSONDecoder().decode([posts].self, from: data)
    }
    
    func deleteMessages(ID: String){
        let url = "https://bears-nation-api.herokuapp.com/messages/\(ID)"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")


        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error!)")
                return
            }
            do {
                if (try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]) != nil{
                //print(response!)
            }
            }
            catch {
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexClicked = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Message Board"
        navigationItem.backBarButtonItem = backItem
        let detailedV = segue.destination as? messageBoardDetail
        detailedV?.subject = getData[indexClicked].subject
        detailedV?.index = indexClicked
        detailedV?.responses = getData[indexClicked].replies
        if(segue.identifier == "toDetail"){
           detailedV?.ID = getData[indexClicked]._id
        }
        
    }
    
    
    

}

