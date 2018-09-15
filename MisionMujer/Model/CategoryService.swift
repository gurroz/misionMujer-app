//
//  CategoryService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class CategoryService {
    let categoryDictonary:[String: Category]
    
    static let sharedInstance = CategoryService()
    
    private init() {
        categoryDictonary = Category.getCategoryDictionary()
    }

    func getCategoryDictionary() -> [String: Category] {
        return categoryDictonary;
    }
    
    func getCategoryList() -> [Category] {
        return Array(categoryDictonary.values);
    }

}
