//
//  NewsService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation

class NewsService {
    var newsList:[News]
    let session = URLSession.shared
    let NEWS_URL = Configurations.baseURL + "news/"

    static let sharedInstance = NewsService()
    
    private init() {
//        newsDictonary = News.getNewsDictionary()
        newsList = [News]()
        getRemotNews();
    }

 
    func getNewsList() -> [News] {
        return newsList;
    }
    
    func getDefaulNews() -> News {
        return News()!
    }
    
    func getRemotNews() {
        let url = URL(string: NEWS_URL)!
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
                var parsingError: NSError? = nil
                let parsedResult: Any!
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch let error as NSError {
                    parsingError = error
                    parsedResult = nil
                }
                catch {
                    fatalError()
                }
                
                print(parsingError as Any)
                print(parsedResult)
                
                // Extract an element from the data as an array, if your JSON response returns a dictionary you will need to convert it to an NSDictionary
                if let newsArray = (parsedResult as AnyObject) as? NSArray {
                    for newsJson in newsArray {
                        let actualNews = News(json: (newsJson as! NSDictionary))!
                        self.newsList.append(actualNews)
                    }
                }
            }
        })
        // Execute the task
        task.resume()
    }
    
}
