//
//  NewsDetailViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController  {

    @IBOutlet weak var backgroundCardView: UIView!  {
        didSet {
            backgroundCardView.layer.cornerRadius = 3.0
            backgroundCardView.layer.masksToBounds = false
            backgroundCardView.layer.shadowColor = UIColor.black.cgColor
            backgroundCardView.layer.shadowOffset = CGSize(width: 5, height: 5)
            backgroundCardView.layer.shadowRadius = 5
            backgroundCardView.layer.shadowOpacity = 0.5
        }
    }
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var news:News = News()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = news.title
        textLabel!.text = news.content
        titleLabel!.text = news.title
        dateLabel!.text = "Published: \(news.date)"
        newsImageView!.image =  UIImage(named: news.imageName)
    }
    
}
