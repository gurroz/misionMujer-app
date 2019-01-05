//
//  CategoryAPI.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 1/10/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CategoryAPI: CategoryHandler {
    let session = URLSession.shared
    let CATEGORY_URL = Configurations.baseURL + "categories/"
    
    required init(nextHandler: CategoryHandler?) {}
    
    func getCategories(onCompleted: (([Category]?) -> ())?) {
        self.getRemoteCategories(completion: onCompleted!)
    }
    
    private func getRemoteCategories(completion:  @escaping ([Category]) -> Void) {
        var categories:[Category] = [Category]()
        
        guard let url = URL(string: CATEGORY_URL) else {
            completion(categories)
            return
        }
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success(let value) :
                    let respJSON = JSON(value)
                    guard let value = respJSON["data"].array else {
                        print("Malformed data received from getRemoteCategories service")
                        completion(categories)
                        return
                    }
                    categories = value.compactMap { category in return Category(json: category) }
                    completion(categories)
                    return
                    
                default :
                    print("Error while fetching categories: " + String(describing: response.result.error))
                    completion(categories)
                    return
                }
        }
    }

}


