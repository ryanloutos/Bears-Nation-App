//
//  messagePost.swift
//  Bears-Nation
//
//  Created by Chris Macdonald on 12/8/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class messagePost: UIViewController {


    @IBOutlet weak var usernamePost: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var message: UITextField!
    
//    let url = URL(string: "https://bears-nation-api.herokuapp.com/messages")
    let url = "https://bears-nation-api.herokuapp.com/messages"

    
    struct posts: Decodable {
        let name: String
        let subject: String
        let replyNumber: String
        let replies: [response]
    }
    struct response: Decodable {
        let name: String
        let message: String
    }
    //need this somewhere       performSegue(withIdentifier: "toDetail", sender: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var backButton: UINavigationItem!
    
//    func back(sender: UIBarButtonItem){
//        print("Here")
//        performSegue(withIdentifier: "toMessageBoard", sender: self)
//    }
    
    
    //This is working
    @IBAction func postMessage(_ sender: Any) {
        if(usernamePost.text != ""){
            if(subject.text != ""){
                if(message.text != ""){
                    poster()
                    usernamePost.text = ""
                    subject.text = ""
                    message.text = ""
                } else{
                    print("Please put include a message")
                }

            } else{
                print("Please put include a subject and a message")
            }
        } else{
            print("Please enter a username")
        }
    }
    
    //Posting in swift: https://stackoverflow.com/questions/31937686/how-to-make-http-post-request-with-json-body-in-swift
    func poster(){
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let json: [String: Any] = ["name": usernamePost.text!, "subject": subject.text!, "message": message.text!]
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData
        
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
