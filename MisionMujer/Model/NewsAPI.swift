//
//  NewsAPI.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 1/10/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class NewsAPI: NewsHandler {
    let session = URLSession.shared
    let NEWS_URL = Configurations.baseURL + "news/"
    
    required init(nextHandler: NewsHandler?) {}
    
    func getAllNews(onCompleted: (([News]?) -> ())?) {
        self.getRemotNews(completion: onCompleted!)
    }
    
    private func getRemotNews(completion:  @escaping ([News]) -> Void) {
        let url = URL(string: NEWS_URL)!
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
                
                var newsList:[News] = [News]()
                
                // Extract an element from the data as an array, if your JSON response returns a dictionary you will need to convert it to an NSDictionary
                if let newsArray = parsedResult as? NSArray {
                    for newsJson in newsArray {
                        let newsDictionary = newsJson as! NSDictionary
                        
                        let actualNews = News(json: newsDictionary)
                        newsList.append(actualNews!)
                    }
                }
                DispatchQueue.main.async(execute: {completion(newsList)})
            }
        })
        // Execute the task
        task.resume()
    }
}
