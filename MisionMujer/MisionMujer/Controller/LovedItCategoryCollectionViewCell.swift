//
//  LovedItCollectionCellView.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 15/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//
import UIKit

protocol TeachingPersistanceTrash {
    func deleteTeaching(teaching: Teaching)
}

class LovedItCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBAction func trashBtn(_ sender: UIButton) {
      self.deleteTeachingDelegate!.deleteTeaching(teaching: self.teaching!)
    }
        
    var teaching: Teaching?
    var deleteTeachingDelegate: TeachingPersistanceTrash?
    
}
