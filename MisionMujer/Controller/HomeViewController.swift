//
//  HomeViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var latestImageView: UIImageView!
    @IBOutlet weak var latestTitleLabel: UILabel!
    @IBOutlet weak var latestDescriptionLabel: UILabel!
    @IBOutlet weak var latestDurationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var latestView: UIView! {
        didSet {
            latestView.layer.cornerRadius = 3.0
            latestView.layer.masksToBounds = false
        }
    }
    
    @IBOutlet weak var exploreView: UIView! {
        didSet {
            exploreView.layer.cornerRadius = 3.0
            exploreView.layer.masksToBounds = false
        }
    }
    
    @IBAction func lastButton(_ sender: UIButton){}
    
    var activityIndicatorView: UIActivityIndicatorView!

    var teachingLast:Teaching = TeachingService.sharedInstance.getLatestTeaching()
    var categoryList:[Category] = [Category]()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        latestImageView.image = UIImage(named: teachingLast.imageName)
        latestTitleLabel.text = teachingLast.title
        latestDescriptionLabel.text = teachingLast.description
        latestDurationLabel.text = teachingLast.getDurationInMinutes()
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        collectionView.backgroundView = activityIndicatorView
        
        activityIndicatorView.startAnimating()
        CategoryService.sharedInstance.getRemoteCategories(completion: updateCategoryList)
    }
    
    func updateCategoryList(categories: [Category]) -> Void {
        self.categoryList = categories
        self.activityIndicatorView.stopAnimating()
    
        self.collectionView.reloadData()
    }
}

extension HomeViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryViewCell
        
        let category = categoryList[indexPath.row]
        cell.nameLabel!.text = category.title
        cell.categoryImageView.image = UIImage(named: category.imageName)
        
        if let url = URL(string: category.imageName) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.categoryImageView!.image  = UIImage(data: data!)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToCategoryDetail" {
            let indexPath = self.collectionView.indexPathsForSelectedItems?.first
            let category:Category = categoryList[indexPath!.row]
            
            let categoryVC = segue.destination as! CategoryTeachingViewController
            categoryVC.categoryTitle = category.title
        } else if segue.identifier == "segueToTeachingDetail" {
            let detailVC = segue.destination as! TeachingDetailViewController
            detailVC.teaching = teachingLast
        }
    }
}

class CategoryViewCell : UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
}

