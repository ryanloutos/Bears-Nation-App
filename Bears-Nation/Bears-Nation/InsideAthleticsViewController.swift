//
//  InsideAthleticsViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 12/12/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit
import WebKit

class InsideAthleticsViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont.systemFont(ofSize: 12)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        fetchWebView()

        // Do any additional setup after loading the view.
    }
    
    func fetchWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 145, width: 375, height: 584), configuration: webConfiguration)
        webView.uiDelegate = self
        var url: URL!
        if segmentedControl.selectedSegmentIndex == 0 {
            url = URL(string: "https://washubears.com/athletics_department/mission")
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            url = URL(string: "https://washubears.com/information/directory/home")
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            url = URL(string: "https://www.washubears.com/facilities/athletic-complex")
        }
        else if segmentedControl.selectedSegmentIndex == 3 {
            url = URL(string: "https://www.washubears.com/athletics_department/championships")
        }
        else {
            url = URL(string: "https://www.washubears.com/athletics_department/saac")
        }
        print(url!)
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
        view.addSubview(webView)
    }
    
    @IBAction func barChanged(_ sender: Any) {
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
