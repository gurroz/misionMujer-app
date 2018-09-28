//
//  CategoryService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class CategoryService {
    let session = URLSession.shared
    let CATEGORY_URL = Configurations.baseURL + "categories/"
    
    static let sharedInstance = CategoryService()
    
    private init() {}

    func getRemoteCategories(completion:  @escaping ([Category]) -> Void) {
        let url = URL(string: CATEGORY_URL)!
        let request = URLRequest(url: url)
        
        // Initialise the task for getting the data
        let task = session.dataTask(with: request, completionHandler: {data, response, downloadError in
            if let error = downloadError
            {
                print(error)
            }
            else
            {
                // Parse the data received from the service
                let parsedResult: Any!
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch let error as NSError {
                    print(error)
                    parsedResult = nil
                }
                catch {
                    fatalError()
                }
                
                var categoriesList:[Category] = [Category]()
                
                // Extract an element from the data as an array, if your JSON response returns a dictionary you will need to convert it to an NSDictionary
                if let categoriesArray = parsedResult as? NSArray {
                    for categoryJson in categoriesArray {
                        let categoryDictionary = categoryJson as! NSDictionary
                        
                        let actualCategory = Category(json: categoryDictionary)
                        categoriesList.append(actualCategory!)
                    }
                }
                DispatchQueue.main.async(execute: {completion(categoriesList)})
            }
        })
        // Execute the task
        task.resume()
    }

}
