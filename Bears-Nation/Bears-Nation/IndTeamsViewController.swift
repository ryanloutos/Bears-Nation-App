//
//  IndTeamsViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 11/29/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class IndTeamsViewController: UIViewController {

    @IBOutlet weak var tabSR: UISegmentedControl!
    @IBOutlet weak var teamLabel: UILabel!
    
    var teamName: String!
    var male: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        var nameString: String = ""
        if male {
            nameString = "Men's "
        }
        else {
            nameString = "Women's "
        }
        teamLabel.adjustsFontSizeToFitWidth = true
        teamLabel.text = nameString + teamName
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
