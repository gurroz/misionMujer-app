//
//  HomeViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import SDWebImage

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

    var teachingLast:Teaching = Teaching()
    var categoryList:[Category] = [Category]()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
                
        CategoryService.sharedInstance.getCategoryList(completion: updateCategoryList)
        TeachingService.sharedInstance.getTeachingList(completion: updateTeachingLatest)
    }
    
    func updateCategoryList(categories: [Category]?) {
        if categories != nil {
            self.categoryList = categories!
        }
        
        self.collectionView.reloadData()
    }
    
    func updateTeachingLatest(teachings: [Teaching]?) {
        if (teachings?.count)! > 0 {
            self.teachingLast = teachings![0]

            self.latestImageView.sd_setShowActivityIndicatorView(true)
            self.latestImageView.sd_setIndicatorStyle(.gray)
            self.latestImageView.sd_setImage(with: URL(string: self.teachingLast.imageName), placeholderImage: UIImage(named: "dummy.png"),
                                               completed: { image, error, cacheType, imageURL in
                                                self.teachingLast.image = UIImagePNGRepresentation(image!) as NSData?
                                                TeachingService.sharedInstance.saveTeachingChanges(teaching: self.teachingLast)
            })
            
            latestTitleLabel.text = teachingLast.title
            latestDescriptionLabel.text = teachingLast.description
            latestDurationLabel.text = teachingLast.getDurationInMinutes()

        }
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
        
        cell.categoryImageView.sd_setShowActivityIndicatorView(true)
        cell.categoryImageView.sd_setIndicatorStyle(.gray)
        cell.categoryImageView.sd_setImage(with: URL(string: category.imageName), placeholderImage: UIImage(named: "dummy.png"))
        
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
            categoryVC.category = category
        } else if segue.identifier == "segueToTeachingDetail" {
            let detailVC = segue.destination as! TeachingDetailViewController
            detailVC.teaching = teachingLast
        }
    }
}

class CategoryViewCell : UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var loadingImage: UIActivityIndicatorView!
}

