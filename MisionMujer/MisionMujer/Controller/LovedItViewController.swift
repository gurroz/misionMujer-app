//
//  LovedItViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class LovedItViewController: UITableViewController, TeachingPersistanceTrash {
    var persistedCategories:[Category] = TeachingService.sharedInstance.getPersistedCategory()
    var teachingCollection:[Int: [Teaching]] = TeachingService.sharedInstance.getPersistedDictoniaryTeachingList()
    var storedOffsets = [Int: CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistedCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lovedItCell", for: indexPath) as! LovedItTableViewCell
        let category = persistedCategories[indexPath.row]
        
        cell.categoryLabel.text = category.title
        cell.teachingCollectionView.delegate = self
        cell.teachingCollectionView.dataSource = self
        cell.teachingCollectionView.tag = Int(category.id)
        cell.teachingCollectionView.accessibilityIdentifier = "lovedItTable"

        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? LovedItTableViewCell else { return }
        tableViewCell.teachingCollectionView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? LovedItTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func deleteTeaching(teaching: Teaching) {
        let destroyAction = UIAlertAction(title: "Delete", style: .destructive) {
            (action) in
            // Respond to user selection of the action
            TeachingService.sharedInstance.deletePersistedTeaching(teaching: teaching)
            self.refreshData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            (action) in
        }
        
        let alert = UIAlertController(title: "Delete this teaching?",message: "This will erase the file permanently", preferredStyle: .actionSheet)
        alert.addAction(destroyAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {}
        
    }
    
    func refreshData() {
        persistedCategories = TeachingService.sharedInstance.getPersistedCategory()
        teachingCollection = TeachingService.sharedInstance.getPersistedDictoniaryTeachingList()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teachingDetailSegue" {
            let destinationVC = segue.destination as! TeachingDetailViewController
            destinationVC.teaching = sender as! Teaching
        }
    }
}

extension LovedItViewController: UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let teachingList = getTeachingFromDictionary(categoryId: collectionView.tag)
        
        return teachingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lovedItTeachingCell", for: indexPath) as! LovedItCategoryCollectionViewCell
        let teachingList = getTeachingFromDictionary(categoryId: collectionView.tag)

        let teaching = teachingList[indexPath.row]
        
        cell.deleteTeachingDelegate = self
        cell.teaching = teaching
        cell.titleLabel.text = teaching.title
        cell.teachingImageView.image = UIImage(named: teaching.imageName)
        return cell
    }
    
    func getTeachingFromDictionary(categoryId: Int) -> [Teaching] {
        let teachingList = (teachingCollection[categoryId] != nil) ? teachingCollection[categoryId]! : [Teaching]()
        
        return teachingList
    }
    
}

extension LovedItViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teachingList = getTeachingFromDictionary(categoryId: collectionView.tag)
        let teaching = teachingList[indexPath.row]
        
        self.performSegue(withIdentifier: "teachingDetailSegue", sender: teaching)
    }
}
