//
//  IndAthleteViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 12/4/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class IndAthleteViewController: UIViewController {

    @IBOutlet weak var yr: UILabel!
    @IBOutlet weak var b: UILabel!
    @IBOutlet weak var hs: UILabel!
    @IBOutlet weak var ht: UILabel!
    @IBOutlet weak var wt: UILabel!
    @IBOutlet weak var home: UILabel!
    @IBOutlet weak var pos: UILabel!
    @IBOutlet weak var batsThrows: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var _id: String!
    var name: String!
    var number: String!
    var year: String!
    var height: String!
    var weight: String!
    var bats_throws: String!
    var hometown: String!
    var high_school: String!
    var position: String!
    var events: String!
    var team: String!
    var bio: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        if(number == "") {
            topLabel.text = name
        }
        else {
            topLabel.text = "#" + number + " " + name
        }
        topLabel.adjustsFontSizeToFitWidth = true
        playerDescription()
        // Do any additional setup after loading the view.
    }
    
    func playerDescription() {
                let yearText = UILabel(frame: CGRect(x: yr.center.x + 27, y: yr.center.y - 10, width: CGFloat(40), height: CGFloat(21)))
                yearText.text = year
                scrollView.addSubview(yearText)
        
                let heightText = UILabel(frame: CGRect(x: ht.center.x + 35, y: ht.center.y - 10, width: CGFloat(40), height: CGFloat(21)))
                heightText.text = height
                scrollView.addSubview(heightText)
        
        if weight != "" {
                let weightText = UILabel(frame: CGRect(x: wt.center.x + 35, y: wt.center.y - 10, width: CGFloat(100), height: CGFloat(21)))
                weightText.text = weight + " lbs."
                scrollView.addSubview(weightText)
        }
                
        if bats_throws != "" {
                let btText = UILabel(frame: CGRect(x: batsThrows.center.x + 15, y: batsThrows.center.y + 17, width: CGFloat(40), height: CGFloat(21)))
                btText.text = bats_throws
                scrollView.addSubview(btText)
        }
        else {
            batsThrows.alpha = 0
        }

                let homeText = UILabel(frame: CGRect(x: home.center.x + 49, y: home.center.y - 10, width: CGFloat(200), height: CGFloat(21)))
                homeText.text = hometown
        homeText.adjustsFontSizeToFitWidth = true
                scrollView.addSubview(homeText)
        
                let hsText = UILabel(frame: CGRect(x: hs.center.x + 54, y: hs.center.y - 10, width: CGFloat(200), height: CGFloat(21)))
                hsText.text = high_school
        hsText.adjustsFontSizeToFitWidth = true
                scrollView.addSubview(hsText)
            
        if position != "" {
                let posText = UILabel(frame: CGRect(x: pos.center.x + 35, y: pos.center.y - 10, width: CGFloat(40), height: CGFloat(21)))
                posText.text = position
                scrollView.addSubview(posText)
        }
        else if events != "" {
                pos.text = "Events:"
                let eventsText = UILabel(frame: CGRect(x: pos.center.x + 30, y: pos.center.y - 10, width: CGFloat(200), height: CGFloat(21)))
                eventsText.text = events
                scrollView.addSubview(eventsText)
        }
        else {
            pos.alpha = 0
        }

        let bioText = UILabel(frame: CGRect(x: 10, y: b.frame.origin.y + b.frame.height + 10, width: 330, height: 100))
        bioText.center.x = scrollView.center.x
                bioText.text = bio
        bioText.numberOfLines = 0
        bioText.lineBreakMode = .byWordWrapping
                scrollView.addSubview(bioText)
        bioText.sizeToFit()
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: bioText.frame.origin.y + bioText.frame.height)
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
