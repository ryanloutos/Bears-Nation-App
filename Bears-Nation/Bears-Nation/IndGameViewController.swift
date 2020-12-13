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

    var game: Game!
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var opponentLogo: UIImageView!
    @IBOutlet weak var opponentLabel: UILabel!

    var scrollView: UIScrollView!
    
    func prepUrl(urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {return nil}
        let myURLRequest = URLRequest(url: url)
        return myURLRequest
    }
    
    // display the cell on top
    func displayCell() {
        teamLabel.text = game.team_name
        var colon = ""
        if game.result != "" {
            colon = ":"
        }
        resultLabel.text = "\(game.status)\(colon) \(game.result)"

        if let opponentImage = game.image {
            opponentLogo.image = opponentImage
        }

        if game.home {
            opponentLabel.text = "vs \(game.opponent)"
        }
        else {
            opponentLabel.text = "at \(game.opponent)"
        }
    }
    
    // display each webview and label
    func displayWebView(curTop: CGFloat, labelText: String, page: String) -> CGFloat {
        let pageLabel = UILabel(frame: CGRect(x: 0, y: curTop, width: scrollView.frame.width, height: 40))
        pageLabel.center.x = scrollView.center.x
        pageLabel.text = labelText
        pageLabel.textAlignment = .center
        pageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        pageLabel.textColor = UIColor(named: "WashUGreen")
        
        let webView = WKWebView(frame: CGRect(x: 0, y: pageLabel.frame.origin.y + pageLabel.frame.height + 20, width: scrollView.frame.width - 100, height: 400))
        webView.center.x = scrollView.center.x
        guard let url = URL(string: page) else {return 0}
        let myURLRequest = URLRequest(url: url)
        webView.load(myURLRequest)
        
        let webViewBackground = UIView(frame: CGRect(x: 0, y: 0, width: webView.frame.width + 10, height: webView.frame.height + 10))
        webViewBackground.center = webView.center
        webViewBackground.backgroundColor = .systemGray2
        
        scrollView.addSubview(pageLabel)
        scrollView.addSubview(webViewBackground)
        scrollView.addSubview(webView)
        
        return webView.frame.origin.y + webView.frame.height + 40
    }
    
    func displayAllWebViews() {
        var curTop: CGFloat = 40
        
        if game.live_stats_page != "" {
            curTop = displayWebView(curTop: curTop, labelText: "Live Stats", page: game.live_stats_page)
        }
        
        if game.results_page != "" {
            curTop = displayWebView(curTop: curTop, labelText: "Results", page: game.results_page)
        }
        
        if game.recap_page != "" {
            curTop = displayWebView(curTop: curTop, labelText: "Recap", page: game.recap_page)
        }
        
        // set the size of scroll view
        scrollView.contentSize = CGSize(width:view.frame.width, height: curTop + 300)
        
    }
    
    func setUpScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 267, width: view.frame.width, height: view.frame.height))
        scrollView.isScrollEnabled = true
        view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        displayCell()
        
        setUpScrollView()
        
        displayAllWebViews()
        
        
        
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
