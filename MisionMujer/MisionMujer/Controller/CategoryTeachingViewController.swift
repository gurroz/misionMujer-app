//
//  CategoryTeachingViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryTeachingViewController: UITableViewController  {

    var teachingList:[Teaching] = []
    var category: Category?
    var activityIndicatorView: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.title
        tableView.backgroundView = activityIndicatorView
        
        TeachingService.sharedInstance.getTeachingList(completion: updateTeachingList)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTeachingCell", for: indexPath) as! TeachingTableViewCell
        
        let teaching:Teaching = teachingList[indexPath.row]
        
        cell.titleLabel!.text = teaching.title
        cell.descriptionLabel!.text = teaching.description
        cell.categoryLabel!.text = teaching.getCategoriesAsString()
        cell.durationLabel!.text = teaching.getDurationInMinutes()
        
        cell.teachingImageView.sd_setShowActivityIndicatorView(true)
        cell.teachingImageView.sd_setIndicatorStyle(.gray)
        cell.teachingImageView.sd_setImage(with: URL(string: teaching.imageName), placeholderImage: UIImage(named: "dummy.png"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow!
        let teaching:Teaching = teachingList[indexPath.row]
        
        let detailVC = segue.destination as! TeachingDetailViewController
        detailVC.teaching = teaching
    }
    
    func updateTeachingList(teachings: [Teaching]?) {
        self.teachingList = teachings!.filter{ $0.categories.contains(where: { (category) -> Bool in
            if category.id == self.category?.id {
                return true
            }
            return false
        })}
        
        self.tableView.reloadData()
    }
}
