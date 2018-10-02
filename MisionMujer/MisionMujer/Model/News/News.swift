//
//  News.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 27/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
public struct News {
    
    var id:Int64
    var title:String
    var description:String
    var content:String
    var date:String
    var imageName:String
    
    init?() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.content = ""
        self.date = ""
        self.imageName = ""
    }
    
    init?(json: NSDictionary) {
        guard let id = json["id"] as? Int64,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let content = json["content"] as? String,
            let date = json["published"] as? String,
            let imageName = json["image"] as? String
            else {
                return nil
            }
        
        self.id = id
        self.title = title
        self.description = description
        self.content = content
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let dateParsed = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "dd/MMM/yyyy"
        let finalDate = dateFormatter.string(from: dateParsed!)
        
        self.date = finalDate
        self.imageName = imageName
    }
}
