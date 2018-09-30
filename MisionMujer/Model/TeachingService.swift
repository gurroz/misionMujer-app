//
//  TeachingService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class TeachingService {
    static let sharedInstance = TeachingService()

    private let teachingHandler: TeachingHandler
    
    private init() {
        let teachingApiHandler = TeachingAPI(nextHandler: nil)
        teachingHandler = TeachingCache(nextHandler: teachingApiHandler)
    }
    
    
    func getTeachingList(completion: (([Teaching]?) -> ())?) -> Void {
        teachingHandler.getAllTeachings(onCompleted: completion)
    }
    
    func getLatestTeaching() -> Teaching {
//        return Array(teachingDictonary.values)[0];
        return Teaching()
    }
    
    func getPersistedTeachingList() -> [Teaching] {
//        return Array(teachingPersistedDictonary.values)
        return [Teaching]()
    }
    
    func getPersistedDictoniaryTeachingList() -> [String: [Teaching]] {
//        return getTeachingCategoryDictionary();
        return [:]
    }
    
    func isTeachingPersisted(teaching: Teaching) -> Bool {
//        if teachingPersistedDictonary[teaching.id] != nil {
//            return true
//        }
//
        return false
    }
    
    func persistTeaching(teaching: Teaching) {
//        teachingPersistedDictonary.updateValue(teaching, forKey: teaching.id)
    }
    
    func deletePersistedTeaching(teaching: Teaching) {
//        teachingPersistedDictonary.removeValue(forKey: teaching.id)
    }
    
    func getTeachingList(categoryName: String) -> [Teaching] {
        let categoryCleansed = cleanCatName(categoryName: categoryName)
//        let teachings =  getTeachingList().filter { (teaching) -> Bool in
//            var response = false
//            for category in teaching.category {
//                let currentCatCleansed = cleanCatName(categoryName: category)
//                if currentCatCleansed.contains(categoryCleansed) {
//                    response = true
//                }
//            }
//            return response
//        }
//        return teachings;
        return [Teaching]()
    }
    
    func cleanCatName(categoryName: String) -> String{
        return categoryName.replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    func getTeachingCategoryDictionary() ->[String:[Teaching]]
    {
        var categoryTeachingDictionary:[String:[Teaching]] = [:]
//        for teaching in getPersistedTeachingList() {
//            let teachingteachings = teaching.category
//            for category in teachingteachings {
//                let categoryCleaned = cleanCatName(categoryName: category)
//                var actualList = categoryTeachingDictionary[categoryCleaned] ?? [Teaching]()
//                actualList.append(teaching)
//
//                categoryTeachingDictionary.updateValue(actualList, forKey: categoryCleaned)
//            }
//        }
        
        return categoryTeachingDictionary
    }
    
    func getPersistedCategory() ->[String] {
        var teachings:[String] = []
//        for teaching in getPersistedTeachingList() {
//            let teachingteachings = teaching.category
//            for category in teachingteachings {
//                if !teachings.contains(category) {
//                    teachings.append(category)
//                }
//            }
//        }
        
        return teachings
    }
    
}
