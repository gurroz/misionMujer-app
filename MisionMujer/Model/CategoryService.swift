//
//  CategoryService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class CategoryService {
   
    static let sharedInstance = CategoryService()
    private let categoryHandler: CategoryHandler

    private init() {
        let categoryApiHandler = CategoryAPI(nextHandler: nil)
        categoryHandler = CategoryCache(nextHandler: categoryApiHandler)
    }

    func getCategoryList(completion: (([Category]?) -> ())?) -> Void {
        categoryHandler.getCategories(onCompleted: completion)
    }

}
