//
//  TeachingDetailView
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class TeachingDetailViewController: UIViewController {
   
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lovedItImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statisticsLabel: UILabel!
    
    var teaching:Teaching = Teaching()
    
    override func viewDidLoad() {
        title = teaching.title
        teachingImageView.image = UIImage(named: teaching.imageName)
        timerLabel.text = String(teaching.duration)
        statisticsLabel.text = "0 times"
        descriptionLabel.text = teaching.description
        dateLabel.text = teaching.date
    }
}
