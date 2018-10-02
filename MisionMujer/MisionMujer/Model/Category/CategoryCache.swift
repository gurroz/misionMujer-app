//
//  CategoryCache.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 1/10/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class CategoryCache: CategoryHandler {
    private var categories: [Category]
    private var nextHandler: CategoryHandler
    
    required init(nextHandler: CategoryHandler?) {
        self.categories = [Category]()
        self.nextHandler = nextHandler!
    }
    
    func getCategories(onCompleted: (([Category]?) -> ())?) {
        if self.categories.count > 0 {
            onCompleted?(self.categories)
        } else {
            nextHandler.getCategories() { categories in
                if categories != nil {
                    self.categories = categories!
                }
                onCompleted?(categories)
            }
        }
    }
    
    
}
