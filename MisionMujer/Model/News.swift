//
//  News.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 27/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
public struct News {
    
    var id:Int
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
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let content = json["content"] as? String,
            let date = json["date"] as? String,
            let imageName = json["imageName"] as? String
            else {
                return nil
            }
        
        self.id = id
        self.title = title
        self.description = description
        self.content = content
        self.date = date
        self.imageName = imageName
    }
}
