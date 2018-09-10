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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        cell.categoryLabel!.text = String(teaching.duration)
        cell.durationLabel!.text = String(teaching.category)
        cell.teachingImageView!.image =  UIImage(named: teaching.imageName)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // TODO: This is for the detail
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let indexPath = self.tableView.indexPathForSelectedRow!
//        let card:MajorArcanaCard = changeDataSource(indexPath: indexPath as NSIndexPath)
//
//        let detailVC = segue.destination as! TarotCardDetailViewController
//
//        detailVC.cardName = card.imageName
//
//    }
    
    
}
