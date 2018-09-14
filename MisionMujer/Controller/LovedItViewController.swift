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
        teachingCollection = TeachingService.sharedInstance.getPersistedDictoniaryTeachingList()
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
        cell.teachingCollectionView.delegate = self
        cell.teachingCollectionView.dataSource = self
        cell.teachingCollectionView.tag = indexPath.row
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
}

extension LovedItViewController: UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let teachingList = getTeachingFromDictionary(categoryTag: collectionView.tag)
        
        return teachingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lovedItTeachingCell", for: indexPath) as! LovedItCategoryCollectionViewCell
        let teachingList = getTeachingFromDictionary(categoryTag: collectionView.tag)

        let teaching = teachingList[indexPath.row]
        
        cell.titleLabel.text = teaching.title
        cell.teachingImageView.image = UIImage(named: teaching.imageName)
        return cell
    }
    
    func getTeachingFromDictionary(categoryTag: Int) -> [Teaching] {
        let category:Category = persistedCategories[categoryTag]
        let categoryNameCleansed = TeachingService.sharedInstance.cleanCatName(categoryName: category.title)
        let teachingList = (teachingCollection[categoryNameCleansed] != nil) ? teachingCollection[categoryNameCleansed]! : [Teaching]()
        
        return teachingList
    }
}

extension LovedItViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _ = cell as! LovedItCategoryCollectionViewCell
        NSLog("Ahora en el collectionView willDisplay \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("Ahora en el collectionView didSelectItemAt \(indexPath.row)")
    }
}
