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
    
    static let sharedInstance = TeachingService()
    
    private init() {
        teachingDictonary = Teaching.getTeachingDictionary()
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
    
    func getPersistedTeachingList() -> [String: [Teaching]] {
        return Teaching.getTeachingCategoryDictionary();
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
}
