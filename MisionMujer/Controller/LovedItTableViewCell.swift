//
//  LovedItTableViewCell
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class LovedItTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var teachingCollectionView: UICollectionView!
    
    var teachingCollection:[Teaching] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        teachingCollectionView.dataSource = self
        teachingCollectionView.delegate = self
        teachingCollection = TeachingService.sharedInstance.getPersistedTeachingList(categoryName: categoryLabel.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = teachingCollection.count
        NSLog("Amount of teachings \(count)")
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lovedItTeachingCell", for: indexPath) as! LovedItCategoryCollectionViewCell
        let teaching = teachingCollection[indexPath.row]

        cell.titleLabel.text = teaching.title
        cell.teachingImageView.image = UIImage(named: teaching.imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
}

class LovedItCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trashImageView: UIImageView!
    
    
}
