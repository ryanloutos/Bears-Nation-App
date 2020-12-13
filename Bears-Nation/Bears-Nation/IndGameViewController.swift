//
//  IndGameViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 12/13/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit
import WebKit

class IndGameViewController: UIViewController {

    
    func prepUrl(urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {return nil}
        let myURLRequest = URLRequest(url: url)
        return myURLRequest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if let myURLRequest = prepUrl(urlString: "https://washubears.com/sports/wvball/2018-19/boxscores/20180908_ku1q.xml") {
//            webView.load(myURLRequest)
//        }
        
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
