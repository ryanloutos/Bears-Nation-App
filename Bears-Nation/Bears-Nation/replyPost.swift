//
//  replyPost.swift
//  Bears-Nation
//
//  Created by Chris Macdonald on 12/8/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class replyPost: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var reply: UITextField!
    
    var id: String = ""
    
    var url: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        url = "https://bears-nation-api.herokuapp.com/messages/\(id)/reply"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        url = "https://bears-nation-api.herokuapp.com/messages/\(id)/reply"
    }
    
    
    
    @IBAction func post(_ sender: Any) {
        if(username.text != ""){
                if(reply.text != ""){
                    poster()
                } else{
                    print("Please put include a message")
                }
            } else{
                print("Please put include a subject and a message")
            }
    }
    
    //Posting in swift: https://stackoverflow.com/questions/31937686/how-to-make-http-post-request-with-json-body-in-swift
    func poster(){
        print(NSURL(fileURLWithPath: url))
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let json: [String: Any] = ["name": username.text!, "message": reply.text!]

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
