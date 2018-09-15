//
//  Category.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
enum Category:Int {
    case energize=1, goodSleep, chakras, mindfulness, mostPlayed, continueWatching
    
    init() {
        self = .energize
    }
    
    init?(number:Int)
    {
        switch number {
        case 1 : self = .energize
        case 2: self = .goodSleep
        case 3: self = .chakras
        case 4: self = .mindfulness
        case 5: self = .mostPlayed
        case 6: self = .continueWatching
        default: return nil
        }
    }
    
    var id:Int {
        get{
            return self.rawValue
        }
    }
    
    var title:String
    {
        get
        {
            switch self
            {
            case .energize : return "Energize"
            case .goodSleep : return "Good Sleep"
            case .chakras : return "Chakras"
            case .mindfulness: return "Mindfulness"
            case .mostPlayed: return "Most Played"
            case .continueWatching:  return "Continue Watching"
            }
        }
    }
    
    var imageName:String
    {
        get
        {
            let name = "category\(self.id)"
            return name
        }
    }
    
    static func getCategory() ->[Category]
    {
        return [energize, goodSleep, chakras, mindfulness]
    }
    
    static func getCategoryDictionary() ->[String:Category]
    {
        var categoryDictionary:[String:Category] = [:]
        for category in getCategory() {
            categoryDictionary.updateValue(category, forKey: String(category.id))
        }
        
        return categoryDictionary
    }
}
