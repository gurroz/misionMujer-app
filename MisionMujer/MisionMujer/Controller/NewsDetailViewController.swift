//
//  NewsDetailViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import SDWebImage

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var backgroundCardView: UIView!  {
        didSet {
            backgroundCardView.layer.cornerRadius = 3.0
            backgroundCardView.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var news:News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewsOnView()
    }
    
    func setNewsOnView() {
        title = news!.title
        textLabel!.text = news!.content
        titleLabel!.text = news!.title
        dateLabel!.text = "Published: \(news!.date)"

        self.newsImageView.sd_setShowActivityIndicatorView(true)
        self.newsImageView.sd_setIndicatorStyle(.gray)
        self.newsImageView.sd_setImage(with: URL(string: news!.imageName), placeholderImage: UIImage(named: "dummy.png"))
    }
}

extension NewsDetailViewController: RefreshNews {
    
    func refreshItem(news: News) {
        self.news = news
        self.loadView()
        setNewsOnView()
    }
    
    
}
