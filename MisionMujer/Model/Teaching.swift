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
    var duration:Int
    var type:String
    var imageName:String
    var image: Data!
    var media: String
    
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
    }
    
    init?(json: NSDictionary) {
        guard let id = json["id"] as? Int64,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let notes = json["content"] as? String,
            let date = json["published"] as? String,
            let type = json["type"] as? String,
            let categories = json["categories"] as? NSArray,
            let duration = json["length"] as? Int,
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
        self.date = getDateInFormat(dateStr: date)
        self.categories = getCategoriesFromJson(jsonCategories: categories)
    }
    
    mutating func setImageAsData(imgData: Data) -> Void {
        self.image = imgData
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
