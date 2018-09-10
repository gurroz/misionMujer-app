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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let indexPath = self.tableView.indexPathForSelectedRow!
        let teaching:Teaching = changeDataSource(indexPath: indexPath as NSIndexPath)

        let detailVC = segue.destination as! TeachingDetailViewController

        detailVC.teaching = teaching
    }
    
    
}
