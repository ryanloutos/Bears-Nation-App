//
//  GamedayViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 12/12/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit
import WebKit

class GamedayViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var segIndex: UISegmentedControl!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWebView()
        // Do any additional setup after loading the view.
    }
    
    func fetchWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 145, width: 375, height: 584), configuration: webConfiguration)
        webView.uiDelegate = self
        var url: URL!
        if segIndex.selectedSegmentIndex == 0 {
            url = URL(string: "https://washubears.com/athletics_department/Tailgating")
        }
        else if segIndex.selectedSegmentIndex == 1 {
            url = URL(string: "https://washubears.com/athletics_department/Ticketing")
        }
        else if segIndex.selectedSegmentIndex == 2 {
            url = URL(string: "https://washubears.com/athletics_department/WU_Visiting_Team_Guide.pdf")
        }
        else {
            url = URL(string: "https://washubears.com/fan-central/washu-sports-network")
        }
        print(url!)
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
        view.addSubview(webView)
    }
    
    @IBAction func selectionChanged(_ sender: Any) {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activitySpinner = UIActivityIndicatorView.init(style: .large)
        activitySpinner.startAnimating()
        activitySpinner.center = spinnerView.center
        spinnerView.addSubview(activitySpinner)
        view.addSubview(spinnerView)
        webView.removeFromSuperview()
        fetchWebView()
        spinnerView.removeFromSuperview()
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
