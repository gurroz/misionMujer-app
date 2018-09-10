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
    
    func getPersistedTeachingList(categoryName: String) -> [Teaching] {
        let teachings =  Array(teachingDictonary.values)
        return teachings;
    }
    
    func getTeachingList(categoryName: String) -> [Teaching] {
        let teachings =  Array(teachingDictonary.values).filter { (teaching) -> Bool in
            return teaching.category.lowercased().contains(categoryName.lowercased())
        }
        return teachings;
    }
}
