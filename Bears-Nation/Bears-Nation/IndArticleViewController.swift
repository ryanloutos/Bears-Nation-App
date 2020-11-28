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
        
        view.backgroundColor = .white
        
        // hard-coded values for now, will change later (to accompany all phones)
        
        let topLine = UIView(frame: CGRect(x: 19, y: 110, width: 336, height: 3))
        topLine.backgroundColor = .systemRed
        
        let titleSizeMultiplier = (article.title.count / 15) + 1
        let titleHeight = 40 * titleSizeMultiplier
        let titleLabel = UILabel(frame: CGRect(x: 63, y: 110, width: 248, height: titleHeight))
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
        
        view.addSubview(topLine)
        view.addSubview(titleLabel)
        view.addSubview(bottomLine)
        view.addSubview(articleImage)
        
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
