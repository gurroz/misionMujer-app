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
import SDWebImage

class TeachingDetailViewController: UIViewController, URLSessionDataDelegate {
   
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statisticsLabel: UILabel!
    @IBAction func loveItButtn(_ sender: UIButton) {
        persistTeaching()
    }
    
    @IBOutlet weak var loveItImageBtn: UIButton!
    @IBAction func playButton(_ sender: UIButton) {
       playVideo()
    }
    
    @IBOutlet weak var downloadProgressView: UIProgressView!
    
    var teaching:Teaching = Teaching()
    var isTeachingPersisted: Bool = false
    
    override func viewDidLoad() {
        let existingTeaching = TeachingService.sharedInstance.getPersistedTeaching(teaching: teaching)
        isTeachingPersisted = existingTeaching.isPersisted
        
        if existingTeaching.id != 0 {
            teaching = existingTeaching
        }

       
        if teaching.image != nil {
            self.teachingImageView.image = UIImage(data: teaching.image as Data)
        } else {
            self.teachingImageView.sd_setShowActivityIndicatorView(true)
            self.teachingImageView.sd_setIndicatorStyle(.gray)
            self.teachingImageView.sd_setImage(with: URL(string: teaching.imageName), placeholderImage: UIImage(named: "dummy.png"))
        }
        
        title = teaching.title
        timerLabel.text = teaching.getDurationInMinutes()
        statisticsLabel.text = "\(String(teaching.views)) views"
        descriptionLabel.text = teaching.notes
        dateLabel.text = teaching.date
        
        updateLoveItImageStatus()
    }
    
    func playVideo() {
        var url = URL(string: teaching.media)
        
        if isTeachingPersisted {
            TeachingService.sharedInstance.updateTeachingStatistics(teaching: teaching)
            statisticsLabel.text = "\(String(teaching.views + 1)) views"
            if teaching.localMedia != nil {
                url = teaching.localMedia
            }
        } else if url == nil {
            return
        }
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url!)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: nil)
        player.play()
    }
    
    func persistTeaching() {
        if !isTeachingPersisted {
            downloadProgressView.isHidden = false
            TeachingService.sharedInstance.downloadTeaching(teaching: teaching, onSuccess: succesDownloading, onError: errorPersisting, onUpdate: updateDownloadProgress)
        }
    }
    
    func succesDownloading(teaching: Teaching) {
        TeachingService.sharedInstance.persistTeaching(teaching: teaching, onSuccess: successPersisting)
    }
    
    func successPersisting(_ teaching: Teaching) {
        isTeachingPersisted = true
        self.teaching = teaching
        downloadProgressView.isHidden = true
        updateLoveItImageStatus()
    }
    
    func updateDownloadProgress(_ progress: Float) {
        downloadProgressView.progress = progress
    }
    
    func errorPersisting(_ msg: String) {
        downloadProgressView.isHidden = false
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateLoveItImageStatus() {
        if isTeachingPersisted {
            loveItImageBtn.imageView?.image = loveItImageBtn.imageView?.image!.withRenderingMode(.alwaysTemplate)
            loveItImageBtn.imageView?.tintColor = UIColor(red: 237/255.0, green: 78/255.0, blue: 78/255.0, alpha: 1)
        } else {
            loveItImageBtn.imageView?.image = loveItImageBtn.imageView?.image!.withRenderingMode(.alwaysTemplate)
            loveItImageBtn.imageView?.tintColor = UIColor(red: 46/255.0, green: 196/255.0, blue: 182/255.0, alpha: 1)
        }
    }
}
