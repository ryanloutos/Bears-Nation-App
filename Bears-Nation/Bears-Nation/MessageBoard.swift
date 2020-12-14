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
    
    var subjectArr = ["Can the bears do it", "We won!!!!!!", "Nao Is looking stronger than ever", "Ryan Pitches no hitter", "Bo goes yard!!"]
    var replyArr = ["5", "5", "5", "5", "5"]
    
    var userNames: [String] = ["GoBears", "BoDaBear", "Ryan_UAABaseball", "Nao", "ChrisMacdonald", "BearLuver"]
    var mreponses: [String] = ["With such a good goal keepings from the womens soccer team abd a strong defense, I don't see many goals being scored on them this season.  Their only threat is the powerful offense of UChicagp", "I see them making the finals and playing a tight game against UChicago", "Their defense is very strong, but definitley have the ability to score goals!", "Don't forget about emory's senior Jessica.  A four year starter at forward and first team all-american last year", "I can't see how they lose!!!!", "I agree.  Go Bears"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let cell = tableView.dequeueReusableCell(withIdentifier: "theCell") as! tableViewHandler
        cell.repliesMain.text = "Replies: " + replyArr[indexPath.row]
        cell.subjectMain.text = subjectArr[indexPath.row]
        
        return cell
    }
    
    struct myData: Decodable {
        let posts:[post]
    }
    struct post: Decodable {
        let name: String
        let title: String
        let replyNumber: String
        let replies: [response]
    }
    struct response: Decodable {
        let name: String
        let message: String
    }
    
    

    
    var postData: myData = myData(posts: [])
    var indexClicked: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Row selected")
            print(indexPath.row)
        indexClicked = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Message Board"
        navigationItem.backBarButtonItem = backItem
        let detailedV = segue.destination as? messageBoardDetail
        detailedV?.subject = subjectArr[indexClicked]
        detailedV?.userNames = userNames
        detailedV?.replies = mreponses
    }

}

/*   var incommingData: [String: Any] = [
"posts": [
    [
        "name": "firstWrigter",
        "tite": "How bout them bears",
        "replyNumber": "4",
        "replies": [
          [
            "name": "firstReply",
            "message": "I agree!"
          ],
          [
            "name": "secondReply",
            "message": "I agree!"
          ],
          [
            "name": "thirdReply",
            "message": "I agree!"
          ],
          [
            "name": "fourthReply",
            "message": "I agree!"
          ]
        ]
    ],
    [
        "name": "secondWrigter",
        "tite": "Bears Win!!!!",
        "replyNumber": "4",
        "replies": [
          [
            "name": "firstReply",
            "message": "I agree!"
          ],
          [
            "name": "secondReply",
            "message": "I agree!"
          ],
          [
            "name": "thirdReply",
            "message": "I agree!"
          ],
          [
            "name": "fourthReply",
            "message": "I agree!"
          ]
        ]
    ]
]
] */

