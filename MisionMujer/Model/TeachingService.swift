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
}
