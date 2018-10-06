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

class TeachingDetailViewController: UIViewController, URLSessionDataDelegate {
   
    @IBOutlet weak var teachingImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statisticsLabel: UILabel!
    @IBAction func loveItButtn(_ sender: UIButton) {
        persistTeaching()
    }
    
    @IBOutlet weak var loadingImage: UIActivityIndicatorView!
    @IBOutlet weak var loveItImageBtn: UIButton!
    @IBAction func playButton(_ sender: UIButton) {
       playVideo()
    }
    
    @IBOutlet weak var downloadProgress: UIView!
    
    var teaching:Teaching = Teaching()
    var isTeachingPersisted: Bool = false
    
    override func viewDidLoad() {
        isTeachingPersisted = TeachingService.sharedInstance.isTeachingPersisted(teaching: teaching)
        
        if teaching.image != nil {
            self.teachingImageView.image = UIImage(data: teaching.image as Data)
        } else {
            loadingImage.startAnimating()
            if let url = URL(string: teaching.imageName) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    self.teaching.setImageAsData(data! as NSData)
                    DispatchQueue.main.async {
                        self.teachingImageView.image = UIImage(data: data!)
                        self.loadingImage.stopAnimating()
                    }
                }
            }
        }
        
        title = teaching.title
        timerLabel.text = teaching.getDurationInMinutes()
        statisticsLabel.text = "\(String(teaching.views)) views"
        descriptionLabel.text = teaching.notes
        dateLabel.text = teaching.date
        
        updateLoveItImageStatus()
    }
    
    func playVideo() {
        guard let url = URL(string: teaching.media) else {
            return
        }
        
        if !isTeachingPersisted {
            TeachingService.sharedInstance.updateTeachingStatistics(teaching: teaching)
            statisticsLabel.text = "\(String(teaching.views + 1)) views"
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
    
    func persistTeaching() {
        if !isTeachingPersisted {
            TeachingService.sharedInstance.persistTeaching(teaching: teaching, onSuccess: successPersisting, onError: errorPersisting)
        }
    }
    
    func successPersisting() {
        isTeachingPersisted = true
        updateLoveItImageStatus()
    }
    
    func errorPersisting(_ msg: String) {
        downloadProgress.isHidden = false
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
