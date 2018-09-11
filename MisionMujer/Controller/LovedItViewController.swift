//
//  LovedItViewController.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit

class LovedItViewController: UITableViewController {
    var persistedCategories:[Category] = CategoryService.sharedInstance.getPersistedCategoryList()
    var teachingCollection:[String: [Teaching]] = TeachingService.sharedInstance.getPersistedDictoniaryTeachingList()
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
    var storedOffsets = [Int: CGFloat]()


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistedCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lovedItCell", for: indexPath) as! LovedItTableViewCell
        let categoryName = persistedCategories[indexPath.row].title
        cell.categoryLabel.text = categoryName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? LovedItTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? LovedItTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

extension LovedItViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category:Category = persistedCategories[collectionView.tag]
        let categoryNameCleansed = category.title.replacingOccurrences(of: " ", with: "").lowercased()
        let teachingList = (teachingCollection[categoryNameCleansed] != nil) ? teachingCollection[categoryNameCleansed]! : [Teaching]()
        
        return teachingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lovedItTeachingCell", for: indexPath) as! LovedItCategoryCollectionViewCell
//        let teaching = teachingCollection[indexPath.row]
        
        cell.titleLabel.text = "hola"
        cell.teachingImageView.image = UIImage(named: "dummy")
        return cell
    }
}
