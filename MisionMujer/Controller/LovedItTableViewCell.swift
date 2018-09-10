//
//  LovedItTableViewCell
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class LovedItTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet private weak var teachingCollectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(dataSourceDelegate: D, forRow row: Int) {
        teachingCollectionView.delegate = dataSourceDelegate
        teachingCollectionView.dataSource = dataSourceDelegate
        teachingCollectionView.tag = row
        teachingCollectionView.reloadData()
    }
}

class LovedItCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trashImageView: UIImageView!
    
}
