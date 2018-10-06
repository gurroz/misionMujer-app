//
//  TeachingService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TeachingService {
    static let sharedInstance = TeachingService()

    // Get a reference to your App Delegate
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Hold a reference to the managed context
    private let managedContext: NSManagedObjectContext
    private let teachingHandler: TeachingHandler
    
    private init() {
        let teachingApiHandler = TeachingAPI(nextHandler: nil)
        teachingHandler = TeachingCache(nextHandler: teachingApiHandler)
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    
    func getTeachingList(completion: (([Teaching]?) -> ())?) -> Void {
        teachingHandler.getAllTeachings(onCompleted: completion)
    }
    
    func getPersistedTeachingList() -> [Teaching] {
        let teachingsDB: [TeachingDB] = self.getTeachingsDB()
        var teachings: [Teaching] =  [Teaching]()
        for teachingDB in teachingsDB {
            teachings.append(Teaching(data: teachingDB)!)
        }
        return teachings
    }
    
    func getPersistedDictoniaryTeachingList() -> [Int: [Teaching]] {
        var teachingDict:  [Int: [Teaching]] =  [:]
        let teachingsDB: [TeachingDB] = self.getTeachingsDB()
        
        for teachingDB in teachingsDB {
            let actualTeaching: Teaching = Teaching(data: teachingDB)!
            for category in actualTeaching.categories {
                let catId = Int(category.id)
                var actualArray = teachingDict[catId] ?? [Teaching]()
                let exists = actualArray.contains { teaching in
                    if teaching.id == actualTeaching.id {
                        return true
                    }
                    return false
                }
                
                if(!exists) {
                    actualArray.append(actualTeaching)
                }
                teachingDict.updateValue(actualArray, forKey: catId)
            }

        }
        
        return teachingDict
    }
    
    func saveTeachingChanges(teaching: Teaching) {
        self.teachingHandler.saveTeachingData(teaching: teaching)
    }
    
    
    func getPersistedTeaching(teaching: Teaching) -> Teaching {
        let teachingsDB: [TeachingDB] = self.getTeachingsDB()
        for teachingDB in teachingsDB {
            if teachingDB.tId == teaching.id {
                return Teaching(data: teachingDB)!
            }
        }
        return Teaching()
    }
    
    func downloadTeaching(teaching: Teaching, onSuccess: @escaping (Teaching) -> (), onError: @escaping (String) -> (), onUpdate: @escaping (Float) -> ()) {
        MediaDownloadService.shared.download(teaching: teaching, onSuccess: onSuccess, onError: onError,  onUpdate: onUpdate)
    }
    
    func persistTeaching(teaching: Teaching, onSuccess: @escaping (Teaching) -> ()) {
        self.saveTeaching(teaching: teaching, onSuccess: onSuccess)
    }
    
    func deletePersistedTeaching(teaching: Teaching) {
        let teachingsDB: [TeachingDB] = self.getTeachingsDB()
        for teachingDB in teachingsDB {
            if teachingDB.tId == teaching.id {
                self.deleteTeachingDB(teachingDB)
            }
        }
    }
    
    func updateTeachingStatistics(teaching: Teaching) {
        self.updateTeachingStatistics(teaching: teaching, viewedTime: 0)
    }
    
    func getPersistedCategory() -> [Category] {
        let categoriesDB:[CategoriesDB] = self.getCategoriesDB()
        var categories:[Category] = [Category]()
        
        for categoryDB in categoriesDB {
            let actualCategory = Category(data: categoryDB)
            if !categories.contains(where: { category in
                if category.id == actualCategory?.id {
                    return true
                }
                return false
            }) {
                categories.append(actualCategory!)
            }
        }
        
        return categories
    }
    
}

// DB Access
extension TeachingService {
    // MARK: - CRUD
    
    private func saveTeaching(teaching: Teaching, onSuccess: (Teaching)->()) {
        // Create a new managed object and insert it into the context, so it can be saved
        // into the database
        let newTeachingDB =  NSEntityDescription.entity(forEntityName: "TeachingDB", in:managedContext)
        
        // Create an object based on the Entity
        let teachingDB = TeachingDB(entity: newTeachingDB!, insertInto: managedContext)
        teachingDB.date = teaching.date
        teachingDB.duration = teaching.duration
        teachingDB.image = teaching.image
        teachingDB.media = teaching.localMedia
        teachingDB.notes = teaching.notes
        teachingDB.tDescription  = teaching.description
        teachingDB.tId = teaching.id
        teachingDB.title = teaching.title
        teachingDB.type = teaching.type
        
        updateDatabase()

        if let teachingCategories = teaching.categories {
            for category in teachingCategories {
                let newCategoryDB =  NSEntityDescription.entity(forEntityName: "CategoriesDB", in:managedContext)
                let categoryDB = CategoriesDB(entity: newCategoryDB!, insertInto: managedContext)
                categoryDB.categoryId = category.id
                categoryDB.title = category.title
                categoryDB.teaching = teachingDB
                updateDatabase()
            }
        }
        
        let newStatisticDB =  NSEntityDescription.entity(forEntityName: "StatisticsDB", in:managedContext)
        let statisticDB = StatisticsDB(entity: newStatisticDB!, insertInto: managedContext)
        
        statisticDB.teaching = teachingDB
        statisticDB.lastViewDuration = 0
        statisticDB.views = 0
        updateDatabase()
        
        print("Teaching saved in DB")

        var newTeaching = teaching
        
        newTeaching.setPersisted()
        onSuccess(newTeaching)
    }

    private func getTeachingsDB() -> [TeachingDB] {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TeachingDB")
            let results = try managedContext.fetch(fetchRequest) as! [TeachingDB]
            
            return results
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [TeachingDB]()
    }
    
    private func updateTeachingStatistics(teaching: Teaching, viewedTime: Int32) {
        let teachingsDB: [TeachingDB] = self.getTeachingsDB()
        var statistic: StatisticsDB?
        for teachingDB in teachingsDB {
            if teachingDB.tId == teaching.id {
                statistic = teachingDB.statistics!
                break
            }
        }
        
        statistic?.views =  (statistic?.views)! + 1
        statistic?.lastViewDuration = viewedTime
        updateDatabase()
        
        print("Statistics updated")
    }
    
    private func getCategoriesDB() -> [CategoriesDB] {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoriesDB")
            let results = try managedContext.fetch(fetchRequest) as! [CategoriesDB]
            
            return results
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return [CategoriesDB]()
    }
    
    private func deleteTeachingDB(_ teachingDB: TeachingDB) {
        print("Eliminando teaching")
        print(teachingDB)

        managedContext.delete(teachingDB)
        updateDatabase()
    }

    
    // Save the current state of the objects in the managed context into the
    // database.
    private func updateDatabase() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
