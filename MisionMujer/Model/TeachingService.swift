//
//  TeachingService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class TeachingService {
    let teachingDictonary:[String: Teaching]
    var teachingPersistedDictonary:[Int: Teaching]

    
    static let sharedInstance = TeachingService()
    
    private init() {
        teachingDictonary = Teaching.getTeachingDictionary()
        teachingPersistedDictonary = [Int: Teaching]()
    }

    func getTeachingDictionary() -> [String: Teaching] {
        return teachingDictonary;
    }
    
    func getTeachingList() -> [Teaching] {
        return Array(teachingDictonary.values);
    }
    
    func getLatestTeaching() -> Teaching {
        return Array(teachingDictonary.values)[0];
    }
    
    func getPersistedTeachingList() -> [Teaching] {
        return Array(teachingPersistedDictonary.values)
    }
    
    func getPersistedDictoniaryTeachingList() -> [String: [Teaching]] {
        return getTeachingCategoryDictionary();
    }
    
    func isTeachingPersisted(teaching: Teaching) -> Bool {
        if teachingPersistedDictonary[teaching.id] != nil {
            return true
        }
        
        return false
    }
    
    func persistTeaching(teaching: Teaching) {
        teachingPersistedDictonary.updateValue(teaching, forKey: teaching.id)
    }
    
    func deletePersistedTeaching(teaching: Teaching) {
        teachingPersistedDictonary.removeValue(forKey: teaching.id)
    }
    
    func getTeachingList(categoryName: String) -> [Teaching] {
        let categoryCleansed = cleanCatName(categoryName: categoryName)
        let teachings =  getTeachingList().filter { (teaching) -> Bool in
            var response = false
            for category in teaching.category {
                let currentCatCleansed = cleanCatName(categoryName: category)
                if currentCatCleansed.contains(categoryCleansed) {
                    response = true
                }
            }
            return response
        }
        return teachings;
    }
    
    func cleanCatName(categoryName: String) -> String{
        return categoryName.replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    func getTeachingCategoryDictionary() ->[String:[Teaching]]
    {
        var teachingDictionary:[String:[Teaching]] = [:]
        for teaching in getPersistedTeachingList() {
            let teachingCategories = teaching.category
            for category in teachingCategories {
                let categoryCleaned = cleanCatName(categoryName: category)
                var actualList = teachingDictionary[categoryCleaned] ?? [Teaching]()
                actualList.append(teaching)
                
                teachingDictionary.updateValue(actualList, forKey: categoryCleaned)
            }
        }
        
        return teachingDictionary
    }
    
}
