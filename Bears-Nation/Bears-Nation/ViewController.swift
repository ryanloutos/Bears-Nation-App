//
//  ViewController.swift
//  Bears-Nation
//
//  Created by Nao Yanase on 11/24/20.
//  Copyright © 2020 WashU Athletics. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let dummyArticleNames = ["Title One", "Title Two", "Title Three", "Title Four"]
    
    struct APIResults:Decodable {
        let _id: String
        let title:String
        let date_posted:String
        let content:String
        let __v: Int
    }
    
    var articles: [APIResults] = []
    var imageCache: [UIImage?] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // from Michael Ginn
        cell.contentView.subviews.forEach {$0.removeFromSuperview()}
        
        // if the image doesn't exist, simply display green UIView
        if (imageCache[indexPath.row] != nil) {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
            imageView.image = imageCache[indexPath.row]
            
            cell.contentView.addSubview(imageView)
        }
        else {
            let blankView = UIView(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
            blankView.backgroundColor = UIColor(named: "WashUGreen")
            cell.contentView.addSubview(blankView)
        }

        
        
        let titleView = UIView(frame: CGRect(x: 0, y: cell.bounds.size.height*2/4, width: cell.bounds.size.width, height: cell.bounds.size.height * 2/4))
        titleView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.6)
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(1.0).cgColor, whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0),NSNumber(value: 0.2),NSNumber(value: 1.0)]
        gradient.frame = titleView.bounds
        titleView.layer.mask = gradient

        
        // from https://stackoverflow.com/questions/40575408/outline-uilabel-text-in-uilabel-subclass
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : UIColor.black,
          NSAttributedString.Key.foregroundColor : UIColor.white,
          NSAttributedString.Key.strokeWidth : -0.5,]
          as [NSAttributedString.Key : Any]

        let articleTitle = UILabel(frame: CGRect(x: 0, y: 0, width: titleView.bounds.size.width, height: titleView.bounds.size.height))
        articleTitle.attributedText = NSMutableAttributedString(string: articles[indexPath.row].title, attributes: strokeTextAttributes)
        articleTitle.textColor = .white
        articleTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        articleTitle.numberOfLines = 5
        articleTitle.textAlignment = .center

        
        titleView.addSubview(articleTitle)
        
        cell.contentView.addSubview(titleView)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articleVC = IndArticleViewController()
        
        DispatchQueue.global().async {
            let curArticle = self.articles[indexPath.row]
                   
            let modifiedContent = self.modifyContent(content: curArticle.content)
           
            let indArticle = Article(id: curArticle._id, title: curArticle.title, date_posted: curArticle.date_posted, content: modifiedContent, image: self.imageCache[indexPath.row])
           
            
            articleVC.article = indArticle
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(articleVC, animated: true)
            }
        }
       

    }
    
    // append a newline after every newline
    func modifyContent(content: String) -> String {
            var newContent = ""
            for i in 0..<content.count - 1 {
                
                let startIdx = content.index(content.startIndex, offsetBy: i)
                newContent.append(content[startIdx])
                if content[startIdx].isNewline {
                    newContent.append("\n")
                }
            }
            return newContent
        }

    
    func fetchArticles() {
        // get the articles
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/articles") else {return}
        spinner.startAnimating()
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {return}
            self.articles = try! JSONDecoder().decode([APIResults].self, from: data)
            let cache = self.cacheImages()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.spinner.stopAnimating()
                self.imageCache = cache
            }
        }
    }
    
    func cacheImages() -> [UIImage?] {
        // get the images for each article
        var cache: [UIImage?] = []
        let curData = articles
        for i in 0..<(curData.count) {
            guard let url = URL(string: "https://bears-nation-api.herokuapp.com/articles/image/" + curData[i]._id) else {cache.append(nil); continue}
            guard let data = try? Data(contentsOf: url) else {cache.append(nil); continue}
            guard let image = UIImage(data: data) else {cache.append(nil); continue}
            cache.append(image)
        }
        return cache
    }
    
    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        fetchArticles()
        
    }


}

