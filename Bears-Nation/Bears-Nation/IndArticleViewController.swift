//
//  IndArticleViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 11/27/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class IndArticleViewController: UIViewController {

    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // put everything inside scrollview to allow scrolling for long articles
        let scrollView = UIScrollView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        scrollView.isScrollEnabled = true

        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        // hard-coded values for now, may change later (to accompany all phones)
        
        let titleSizeMultiplier = (article.title.count / 15) + 1
        let titleHeight: CGFloat = CGFloat(40 * titleSizeMultiplier)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: titleHeight))
        titleLabel.text = article.title
        titleLabel.numberOfLines = 5
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        titleLabel.textColor = UIColor(named: "WashUGreen")
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.center.x = view.center.x
        
        let titleBar = UIView(frame: CGRect(x: 0, y: titleLabel.frame.origin.y + titleLabel.frame.height + 8, width: view.frame.width, height: 14))
        titleBar.backgroundColor = UIColor(named: "WashURed")


        let articleImage = UIImageView(frame: CGRect(x: 0, y: titleBar.frame.origin.y + titleBar.frame.height + 8, width: scrollView.frame.width, height: scrollView.frame.width * 0.635))
        articleImage.center.x = view.center.x
        articleImage.image = article.image

        let dateLabel = UILabel(frame: CGRect(x: 0, y: articleImage.frame.origin.y + articleImage.frame.height + 10, width: view.frame.width-75, height: 20))
        dateLabel.text = "Posted \(article.date_posted)"
        dateLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        dateLabel.textColor = .gray
        dateLabel.center.x = view.center.x

        let articleLine = UIView(frame: CGRect(x: 0, y: dateLabel.frame.origin.y + dateLabel.frame.height + 10, width: view.frame.width - 50, height: 3))
        articleLine.backgroundColor = .gray
        articleLine.center.x = view.center.x

        let articleContent = UILabel(frame: CGRect(x: 0, y: articleLine.frame.origin.y + articleLine.frame.height + 10, width: articleLine.frame.width, height: 100))
        articleContent.center.x = view.center.x
        articleContent.text = article.content
        articleContent.numberOfLines = 0
        articleContent.sizeToFit()

        scrollView.addSubview(titleLabel)
        scrollView.addSubview(titleBar)
        scrollView.addSubview(articleImage)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(articleLine)
        scrollView.addSubview(articleContent)
        
        scrollView.contentSize = CGSize(width:view.frame.width, height: articleContent.frame.origin.y + articleContent.frame.height)
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
