//
//  TeachingTableViewCell.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class TeachingTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundCardView: UIView! {
        didSet {
            backgroundCardView.layer.cornerRadius = 3.0
            backgroundCardView.layer.masksToBounds = false
            backgroundCardView.layer.shadowColor = UIColor.black.cgColor
            backgroundCardView.layer.shadowOffset = CGSize(width: 5, height: 5)
            backgroundCardView.layer.shadowRadius = 5
            backgroundCardView.layer.shadowOpacity = 0.5
        }
    }
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
}
