//
//  LetterFromADViewController.swift
//  Bears-Nation
//
//  Created by Bo Anderson on 12/12/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class LetterFromADViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // put everything inside scrollview to allow scrolling for long articles
        let scrollView = UIScrollView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        scrollView.isScrollEnabled = true

        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        // hard-coded values for now, may change later (to accompany all phones)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 40))
        titleLabel.text = "Message from AD"
        titleLabel.font = UIFont(name: "Gill Sans", size: 30)
        titleLabel.textColor = UIColor(named: "WashUGreen")
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.center.x = view.center.x
        
        let titleBar = UIView(frame: CGRect(x: 0, y: titleLabel.frame.origin.y + titleLabel.frame.height + 8, width: view.frame.width, height: 14))
        titleBar.backgroundColor = UIColor(named: "WashURed")


        let articleImage = UIImageView(frame: CGRect(x: 0, y: titleBar.frame.origin.y + titleBar.frame.height + 8, width: 200, height: scrollView.frame.width * 0.635))
        articleImage.center.x = view.center.x
        articleImage.image = UIImage(named: "AzamaHeadshot")

        let dateLabel = UILabel(frame: CGRect(x: 0, y: articleImage.frame.origin.y + articleImage.frame.height + 10, width: view.frame.width-75, height: 20))
        dateLabel.text = "A Note from Anthony J. Azuma"
        dateLabel.font = UIFont(name: "Gill Sans", size: 15)
        dateLabel.textColor = .gray
        dateLabel.center.x = view.center.x

        let articleLine = UIView(frame: CGRect(x: 0, y: dateLabel.frame.origin.y + dateLabel.frame.height + 10, width: view.frame.width - 50, height: 3))
        articleLine.backgroundColor = .gray
        articleLine.center.x = view.center.x

        let articleContent = UILabel(frame: CGRect(x: 0, y: articleLine.frame.origin.y + articleLine.frame.height + 10, width: articleLine.frame.width, height: 100))
        articleContent.center.x = view.center.x
        articleContent.text = "WashU Bears Family,\n\nWashington University is an exceptional place. Year after year, our scholar-champions achieve great success on the fields of play while upholding the rigorous academic standards of this world-class institution. Every day they prove that being academically gifted and athletically talented are not mutually exclusive. Their aspirations as competitors complement the education they receive in the classroom. \n\nAs coaches and administrators, we strive to foster the development of our student-athletes through an unrivaled athletics experience. Our goal is to ensure every scholar-champion competes with passion and integrity, but more important, is well prepared for life beyond the Danforth Campus. \n\nOur athletics program has a proud tradition of excellence and enjoys significant success, both of which are made possible by support from generous alumni, parents, and friends. With your continued commitment, WashU is able to provide our scholar-champions with extraordinary opportunities to excel as competitors, students, and leaders. \n\nThank you for supporting WashU Athletics and investing in the future of our scholar-champions. Your generosity elevates students who demonstrate discipline, leadership, and heart, shaping them for success here at WashU and beyond. \n\nGo Bears! \n\nAnthony J. Azama \nJohn M. Schael Director of Athletics"
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
