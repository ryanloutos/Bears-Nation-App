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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // from Michael Ginn
        cell.contentView.subviews.forEach {$0.removeFromSuperview()}
        

        let titleView = UIView(frame: CGRect(x: 0, y: cell.bounds.size.height*3/4, width: cell.bounds.size.width, height: cell.bounds.size.height/4))
        titleView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let articleTitle = UILabel(frame: CGRect(x: 0, y: 0, width: titleView.bounds.size.width, height: titleView.bounds.size.height))
        articleTitle.text = articles[indexPath.row].title
        articleTitle.textAlignment = .center
        articleTitle.textColor = .white
        articleTitle.font = UIFont(name: "Gill Sans", size: 15)
        articleTitle.numberOfLines = 5
        
        titleView.addSubview(articleTitle)
        
        cell.contentView.addSubview(titleView)
        cell.backgroundColor = UIColor(named: "WashUGreen")
    
        return cell
    }
    
    func fetchMovies() {
        print("here")
        guard let url = URL(string: "https://bears-nation-api.herokuapp.com/articles") else {return}
        spinner.startAnimating()
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {return}
            self.articles = try! JSONDecoder().decode([APIResults].self, from: data)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.spinner.stopAnimating()
            }
        }
        
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
        fetchMovies()
        
    }


}

