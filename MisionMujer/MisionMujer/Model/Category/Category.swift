//
//  Category.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Category {
    
    var id: Int16
    var title:String
    var imageName:String
    
    init?(json: JSON) {
        guard let id = json["id"].int16,
            let title = json["name"].string,
            let imageName = json["image"].string
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.imageName = imageName
    }
    
    init?(data: CategoriesDB) {
        self.id =  data.categoryId
        self.title = data.title!
        self.imageName = ""
    }

}
