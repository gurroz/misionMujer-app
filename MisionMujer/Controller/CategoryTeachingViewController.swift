//
//  CategoryTeachingViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class CategoryTeachingViewController: UITableViewController  {

    var teachingList:[Teaching] = []
    var categoryTitle:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = categoryTitle
        teachingList = TeachingService.sharedInstance.getTeachingList(categoryName: categoryTitle)
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
        cell.categoryLabel!.text = String(teaching.category[0])
        cell.durationLabel!.text = String(teaching.duration)
        cell.teachingImageView!.image =  UIImage(named: teaching.imageName)
        
        return cell
    }
    
}
