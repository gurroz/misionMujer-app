//
//  SearchViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchResultsUpdating  {

    var teachingList:[Teaching] = TeachingService.sharedInstance.getTeachingList()
    var filteredTeaching = [Teaching]()

    let searchController = UISearchController(searchResultsController:nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope:String = "All")
    {
        filteredTeaching = teachingList.filter
        {
            teaching in return teaching.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text! != ""
        {
            return filteredTeaching.count
        }
        
        return teachingList.count
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func changeDataSource(indexPath: NSIndexPath) -> Teaching
    {
        var teaching:Teaching
        if searchController.isActive && searchController.searchBar.text! != ""
        {
            teaching = filteredTeaching[indexPath.row]
        }
        else{
            teaching = teachingList[indexPath.row]
        }
        
        return teaching
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTeachingCell", for: indexPath) as! TeachingTableViewCell
        
        let teaching:Teaching = changeDataSource(indexPath: indexPath as NSIndexPath)
        
        cell.titleLabel!.text = teaching.title
        cell.descriptionLabel!.text = teaching.description
        cell.categoryLabel!.text = String(teaching.duration)
        cell.durationLabel!.text = teaching.category.first
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
