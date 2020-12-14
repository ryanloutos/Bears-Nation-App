//
//  MoreViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 12/12/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func shopButtonPressed(_ sender: Any) {
        let webVC = WebViewController()
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func letterFromADPressed(_ sender: Any) {
        let adVC = LetterFromADViewController()
        navigationController?.pushViewController(adVC, animated: true)
    }
    
    
    
//    @IBAction func gamedayButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "toGameday", sender: self)
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
