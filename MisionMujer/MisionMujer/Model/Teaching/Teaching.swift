//
//  Teaching.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
struct Teaching {
    
    var id:Int64
    var title:String
    var description:String
    var notes:String
    var date:String!
    var categories:[Category]!
    var duration:Int16
    var type:String
    var imageName:String
    var image: NSData!
    var media: String
    var views: Int32
    var isPersisted: Bool
    var localMedia: URL!
    
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.notes = ""
        self.imageName = ""
        self.duration = 0
        self.type = ""
        self.date = ""
        self.media = ""
        self.isPersisted = false
        self.views = 0
    }
    
    init?(json: NSDictionary) {
        guard let id = json["id"] as? Int64,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let notes = json["content"] as? String,
            let date = json["published"] as? String,
            let type = json["type"] as? String,
            let categories = json["categories"] as? NSArray,
            let duration = json["length"] as? Int16,
            let imageName = json["cover"] as? String,
            let media = json["file"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.description = description
        self.notes = notes
        self.imageName = imageName
        self.duration = duration
        self.type = type
        self.media = media
        self.isPersisted = false
        self.views = 0
        self.date = getDateInFormat(dateStr: date)
        self.categories = getCategoriesFromJson(jsonCategories: categories)
    }
    
    init?(data: TeachingDB) {
        self.id = data.tId
        self.title = data.title!
        self.description = data.tDescription!
        self.notes = data.notes!
        self.duration = data.duration
        self.type = data.type!
        self.media = ""
        self.date = data.date!
        self.isPersisted = true
        self.imageName = ""
        self.image = data.image
        self.views = (data.statistics?.views)!
        self.localMedia = data.media

        self.categories = getCategoriesFromDB(categoriesDB: data.categories!)
    }
    
    mutating func setImageAsData(_ imgData: NSData) -> Void {
        self.image = imgData
    }
    
    mutating func setLocalMedia(_ localPath: URL) -> Void {
        self.localMedia = localPath
    }
    
    mutating func setPersisted() -> Void {
        self.isPersisted = true
    }
    
    private func getDateInFormat(dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let dateParsed = dateFormatter.date(from: dateStr)
        
        dateFormatter.dateFormat = "dd/MMM/yyyy"
        let finalDate = dateFormatter.string(from: dateParsed!)
        return finalDate
    }
    
    private func getCategoriesFromJson(jsonCategories: NSArray) -> [Category] {
        var categories: [Category] = [Category]()
        for jsonCategory in jsonCategories {
            let category: Category = Category(json: jsonCategory as! NSDictionary)!
            categories.append(category)
        }
        
        return categories
    }
    
    private func getCategoriesFromDB(categoriesDB: NSSet) -> [Category] {
        let categoriesDBArr = categoriesDB.allObjects as! [CategoriesDB]
        var categories: [Category] = [Category]()
        for categoryDB in  categoriesDBArr {
            let category: Category = Category(data: categoryDB)!
            categories.append(category)
        }
        
        return categories
    }
    
    func getDurationInMinutes() -> String {
        let minutes = self.duration / 60
        return "\(minutes) min"
    }
    
    func getCategoriesAsString() -> String {
        var cateoriesNames:[String] = [String]()
        for category in categories {
            cateoriesNames.append(category.title)
        }
        
        return cateoriesNames.joined(separator: ",")
    }
    
}
