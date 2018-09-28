//
//  TeachingService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class TeachingService {
    static let sharedInstance = TeachingService()
    let session = URLSession.shared
    let TEACHING_URL = Configurations.baseURL + "teachings/"
    
    private init() {}

    func getRemoteTeachings(completion:  @escaping ([Teaching]) -> Void) {
        let url = URL(string: TEACHING_URL)!
        let request = URLRequest(url: url)
        
        // Initialise the task for getting the data
        let task = session.dataTask(with: request, completionHandler: {data, response, downloadError in
            if let error = downloadError {
                print(error)
            } else {
                // Parse the data received from the service
                let parsedResult: Any!
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                } catch let error as NSError {
                    print(error)
                    parsedResult = nil
                } catch {
                    fatalError()
                }
                
                var teachingsList:[Teaching] = [Teaching]()
                
                // Extract an element from the data as an array, if your JSON response returns a dictionary you will need to convert it to an NSDictionary
                if let teachingsArray = parsedResult as? NSArray {
                    for teachingJson in teachingsArray {
                        let teachingDictionary = teachingJson as! NSDictionary
                        
                        let actualTeaching = Teaching(json: teachingDictionary)
                        teachingsList.append(actualTeaching!)
                    }
                }
                DispatchQueue.main.async(execute: {completion(teachingsList)})
            }
        })
        // Execute the task
        task.resume()
    }
    
    
    func getTeachingList() -> [Teaching] {
//        return Array(teachingDictonary.values);
        return [Teaching]()
    }
    
    func getLatestTeaching() -> Teaching {
//        return Array(teachingDictonary.values)[0];
        return Teaching()
    }
    
    func getPersistedTeachingList() -> [Teaching] {
//        return Array(teachingPersistedDictonary.values)
        return [Teaching]()
    }
    
    func getPersistedDictoniaryTeachingList() -> [String: [Teaching]] {
//        return getTeachingCategoryDictionary();
        return [:]
    }
    
    func isTeachingPersisted(teaching: Teaching) -> Bool {
//        if teachingPersistedDictonary[teaching.id] != nil {
//            return true
//        }
//
        return false
    }
    
    func persistTeaching(teaching: Teaching) {
//        teachingPersistedDictonary.updateValue(teaching, forKey: teaching.id)
    }
    
    func deletePersistedTeaching(teaching: Teaching) {
//        teachingPersistedDictonary.removeValue(forKey: teaching.id)
    }
    
    func getTeachingList(categoryName: String) -> [Teaching] {
        let categoryCleansed = cleanCatName(categoryName: categoryName)
//        let teachings =  getTeachingList().filter { (teaching) -> Bool in
//            var response = false
//            for category in teaching.category {
//                let currentCatCleansed = cleanCatName(categoryName: category)
//                if currentCatCleansed.contains(categoryCleansed) {
//                    response = true
//                }
//            }
//            return response
//        }
//        return teachings;
        return [Teaching]()
    }
    
    func cleanCatName(categoryName: String) -> String{
        return categoryName.replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    func getTeachingCategoryDictionary() ->[String:[Teaching]]
    {
        var categoryTeachingDictionary:[String:[Teaching]] = [:]
//        for teaching in getPersistedTeachingList() {
//            let teachingteachings = teaching.category
//            for category in teachingteachings {
//                let categoryCleaned = cleanCatName(categoryName: category)
//                var actualList = categoryTeachingDictionary[categoryCleaned] ?? [Teaching]()
//                actualList.append(teaching)
//
//                categoryTeachingDictionary.updateValue(actualList, forKey: categoryCleaned)
//            }
//        }
        
        return categoryTeachingDictionary
    }
    
    func getPersistedCategory() ->[String] {
        var teachings:[String] = []
//        for teaching in getPersistedTeachingList() {
//            let teachingteachings = teaching.category
//            for category in teachingteachings {
//                if !teachings.contains(category) {
//                    teachings.append(category)
//                }
//            }
//        }
        
        return teachings
    }
    
}
