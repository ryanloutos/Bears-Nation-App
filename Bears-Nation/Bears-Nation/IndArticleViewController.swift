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

        print(article.content)
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        // hard-coded values for now, will change later (to accompany all phones)
        let topLine = UIView(frame: CGRect(x: 19, y: 20, width: 336, height: 3))
        topLine.backgroundColor = .systemRed

        let titleSizeMultiplier = (article.title.count / 15) + 1
        let titleHeight = 40 * titleSizeMultiplier
        let titleLabel = UILabel(frame: CGRect(x: 63, y: 20, width: 248, height: titleHeight))
        titleLabel.numberOfLines = 5
        titleLabel.text = article.title
        titleLabel.font = UIFont(name: "Gill Sans", size: 30)
        titleLabel.textColor = UIColor(named: "WashUGreen")
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()

        let bottomLine = UIView(frame: CGRect(x: 19, y: titleLabel.frame.origin.y + titleLabel.frame.height, width: 336, height: 3))
        bottomLine.backgroundColor = .systemRed

        let articleImage = UIImageView(frame: CGRect(x: 0, y: bottomLine.frame.origin.y + bottomLine.frame.height + 10, width: 275, height: 191))
        articleImage.center.x = view.center.x
        articleImage.image = article.image

        let dateLabel = UILabel(frame: CGRect(x: 19, y: articleImage.frame.origin.y + articleImage.frame.height + 10, width: 300, height: 20))
        dateLabel.text = "Posted \(article.date_posted)"
        dateLabel.font = UIFont(name: "Gill Sans", size: 15)
        dateLabel.textColor = .gray
        dateLabel.center.x = view.center.x

        let articleLine = UIView(frame: CGRect(x: 19, y: dateLabel.frame.origin.y + dateLabel.frame.height + 10, width: 300, height: 3))
        articleLine.backgroundColor = .gray
        articleLine.center.x = view.center.x

        let articleContent = UILabel(frame: CGRect(x: 0, y: articleLine.frame.origin.y + articleLine.frame.height + 10, width: 300, height: 100))
        articleContent.center.x = view.center.x
        articleContent.text = article.content
        articleContent.numberOfLines = 0
        articleContent.sizeToFit()

        scrollView.addSubview(topLine)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(bottomLine)
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
