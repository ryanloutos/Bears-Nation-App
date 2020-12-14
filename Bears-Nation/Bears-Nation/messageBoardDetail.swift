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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    var first:Bool = true
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theCell") as! tableViewHandler
        if(first){
            cell.subjectDetail.text = subject
            first = false
        } else{
            cell.subjectDetail.text = "Re: " + subject

        }
        cell.userDetail.text = "User: " + userNames[indexPath.row]
        cell.messageDetail.text = replies[indexPath.row]
        return cell
    }
    

    var subject: String = ""
    var userNames: [String] = [""]
    var replies: [String] = [""]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        print(subject)
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
