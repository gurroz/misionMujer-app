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
    @IBOutlet weak var teachingCollectionView: UICollectionView!
    var collectionViewOffset: CGFloat {
        set { teachingCollectionView.contentOffset.x = newValue }
        get { return teachingCollectionView.contentOffset.x }
    }

}
