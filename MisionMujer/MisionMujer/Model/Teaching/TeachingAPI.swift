//
//  TeachingAPI.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 30/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class TeachingAPI: TeachingHandler {
    let session = URLSession.shared
    let TEACHING_URL = Configurations.baseURL + "teachings/"
        
    required init(nextHandler: TeachingHandler?) {}
    
    func getTeaching(_ id: Int64, onCompleted: ((Teaching?) -> ())?) {
        onCompleted!(nil) // TODO: Implement individual Teaching API
    }
    
    func getAllTeachings(onCompleted: (([Teaching]?) -> ())?) {
        self.getRemoteTeachings(completion: onCompleted!)
    }
    
    private func getRemoteTeachings(completion:  @escaping ([Teaching]) -> Void) {
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
    
    // Does not apply
    func saveTeachingData(teaching: Teaching) {
    }
    
}
