//
//  TeachingDetailView
//  MisionMujer
//
//  Created by Gonzalo Urroz on 9/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TeachingDetailViewController: UIViewController {
   
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lovedItImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statisticsLabel: UILabel!
    @IBAction func playButton(_ sender: UIButton) {
        guard let url = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") else {
            return
        }
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    var teaching:Teaching = Teaching()
    
    override func viewDidLoad() {
        title = teaching.title
        teachingImageView.image = UIImage(named: teaching.imageName)
        timerLabel.text = teaching.getDurationInMinutes()
        statisticsLabel.text = "0 times"
        descriptionLabel.text = teaching.notes
        dateLabel.text = teaching.date
    }
}
