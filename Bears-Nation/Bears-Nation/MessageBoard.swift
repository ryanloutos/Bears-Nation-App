//
//  MessageBoard.swift
//  Bears-Nation
//
//  Created by Chris Macdonald on 11/27/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class MessageBoard: UIViewController {

    struct MessageContent {
        let title: String
        let RepNum: Int
//        let replies: String
    }
    var posts = [MessageContent]()
    
    let messageBoardPosts: [String: Any] = [
        "title": "This is the title",
        "numReplies": 4,
        "replies": [
            [
                "user": "GoBears",
                "response": "This is the year"],
            [
                "user": "BoDaBear",
                "response": "CAN WE DO IT!!!!!!"]
        ]]

    
    override func viewDidLoad() {
        super.viewDidLoad()


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
