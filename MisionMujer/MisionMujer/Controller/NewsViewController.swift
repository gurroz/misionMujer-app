//
//  NewsViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import SDWebImage

class NewsViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageNewsView: UIImageView!
    @IBOutlet weak var backgroundCardView: UIView! {
        didSet {
            backgroundCardView.layer.cornerRadius = 3.0
            backgroundCardView.layer.masksToBounds = false
        }
    }
}

protocol RefreshNews {
    func refreshItem(news: News)
}

class NewsViewController: UITableViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var newsList:[News] = [News]()
    var actualNews: News?
    var delegate: RefreshNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = activityIndicatorView
        
        NewsService.sharedInstance.getNewsList(completion: getNews)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsViewCell
        
        let news:News =  newsList[indexPath.row]
        
        cell.dateLabel!.text = news.date
        cell.descriptionLabel!.text = news.description
        cell.titleLabel!.text = news.title
        
        cell.imageNewsView.sd_setShowActivityIndicatorView(true)
        cell.imageNewsView.sd_setIndicatorStyle(.gray)
        cell.imageNewsView.sd_setImage(with: URL(string: news.imageName), placeholderImage: UIImage(named: "dummy.png"))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actualNews = newsList[indexPath.row]
        
        self.delegate?.refreshItem(news: self.actualNews!)
        if let detailViewController = self.delegate as? NewsDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow!
        let news:News = newsList[indexPath.row]

        let detailVC = segue.destination as! NewsDetailViewController

        detailVC.news = news
    }
    
    func getNews(news: [News]?) {
        if news != nil {
            self.newsList = news!
        }

        self.tableView.reloadData()
    }
    
}
