//
//  HomeViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class CategoryViewCell : UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var latestImageView: UIImageView!
    @IBOutlet weak var latestTitleLabel: UILabel!
    @IBOutlet weak var latestDescriptionLabel: UILabel!
    @IBOutlet weak var latestDurationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var latestView: UIView! {
        didSet {
            latestView.layer.cornerRadius = 3.0
            latestView.layer.masksToBounds = false
            latestView.layer.shadowColor = UIColor.black.cgColor
            latestView.layer.shadowOffset = CGSize(width: 5, height: 5)
            latestView.layer.shadowRadius = 5
            latestView.layer.shadowOpacity = 0.5
        }
    }
    
    @IBOutlet weak var exploreView: UIView! {
        didSet {
            exploreView.layer.cornerRadius = 3.0
            exploreView.layer.masksToBounds = false
            exploreView.layer.shadowColor = UIColor.black.cgColor
            exploreView.layer.shadowOffset = CGSize(width: 5, height: 5)
            exploreView.layer.shadowRadius = 5
            exploreView.layer.shadowOpacity = 0.5
        }
    }
    
    var teachingLast:Teaching = TeachingService.sharedInstance.getLatestTeaching()
    var categoryList:[Category] = CategoryService.sharedInstance.getCategoryList()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        latestImageView.image = UIImage(named: teachingLast.imageName)
        latestTitleLabel.text = teachingLast.title
        latestDescriptionLabel.text = teachingLast.description
        latestDurationLabel.text = String(teachingLast.duration)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryViewCell
        
        let category = categoryList[indexPath.row]
        cell.nameLabel!.text = category.title
        cell.categoryImageView.image = UIImage(named: category.imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }

}
