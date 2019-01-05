//
//  SearchViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UITableViewController, UISearchResultsUpdating  {

    var teachingList:[Teaching] = [Teaching]()
    var filteredTeaching = [Teaching]()

    let searchController = UISearchController(searchResultsController:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        TeachingService.sharedInstance.getTeachingList(completion: updateTeachingList)
    }
    
    func filterContentForSearchText(searchText: String, scope:String = "All") {
        filteredTeaching = teachingList.filter {
            teaching in return teaching.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text! != "" {
            return filteredTeaching.count
        }
        
        return teachingList.count
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func changeDataSource(indexPath: NSIndexPath) -> Teaching {
        var teaching:Teaching
        if searchController.isActive && searchController.searchBar.text! != "" {
            teaching = filteredTeaching[indexPath.row]
        } else {
            teaching = teachingList[indexPath.row]
        }
        
        return teaching
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTeachingCell", for: indexPath) as! TeachingTableViewCell
        
        var teaching:Teaching = changeDataSource(indexPath: indexPath as NSIndexPath)
        
        cell.titleLabel!.text = teaching.title
        cell.descriptionLabel!.text = teaching.description
        cell.categoryLabel!.text = teaching.getCategoriesAsString()
        cell.durationLabel!.text = teaching.getDurationInMinutes()
        
        cell.teachingImageView.sd_setShowActivityIndicatorView(true)
        cell.teachingImageView.sd_setIndicatorStyle(.gray)
        cell.teachingImageView.sd_setImage(with: URL(string: teaching.imageName), placeholderImage: UIImage(named: "dummy.png"),
                                           completed: { image, error, cacheType, imageURL in
                                            teaching.image = image!.pngData() as NSData?
                                            TeachingService.sharedInstance.saveTeachingChanges(teaching: teaching)
        })
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let indexPath = self.tableView.indexPathForSelectedRow!
        let teaching:Teaching = changeDataSource(indexPath: indexPath as NSIndexPath)

        let detailVC = segue.destination as! TeachingDetailViewController

        detailVC.teaching = teaching
    }
    
    func updateTeachingList(teachings: [Teaching]?) {
        self.teachingList = teachings!
        self.tableView.reloadData()
    }
    
}
