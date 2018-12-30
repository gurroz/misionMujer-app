//
//  News.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 27/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct News {
    
    var id:Int64
    var title:String
    var description:String
    var content:String
    var date:String
    var imageName:String
    var image: NSData!

    init?() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.content = ""
        self.date = ""
        self.imageName = ""
    }
    
    init?(json: JSON) {
        guard let id = json["id"].int64,
            let title = json["title"].string,
            let description = json["description"].string,
            let content = json["content"].string,
            let date = json["published"].string,
            let imageName = json["image"].string
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
    
    
    mutating func setImageAsData(_ imgData: NSData) -> Void {
        self.image = imgData
    }
}
