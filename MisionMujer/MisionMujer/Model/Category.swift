//
//  Category.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
struct Category {
    
    var id: Int16
    var title:String
    var imageName:String
    
    init?(json: NSDictionary) {
        guard let id = json["id"] as? Int16,
            let title = json["name"] as? String,
            let imageName = json["image"] as? String
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
