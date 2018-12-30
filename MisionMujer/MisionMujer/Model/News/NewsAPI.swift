//
//  NewsAPI.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 1/10/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewsAPI: NewsHandler {
    let session = URLSession.shared
    let NEWS_URL = Configurations.baseURL + "news/"
    
    required init(nextHandler: NewsHandler?) {}
    
    func getAllNews(onCompleted: (([News]?) -> ())?) {
        self.getRemotNews(completion: onCompleted!)
    }
    
    private func getRemotNews(completion:  @escaping ([News]) -> Void) {
        var news:[News] = [News]()

        guard let url = URL(string: NEWS_URL) else {
            completion(news)
            return
        }
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success(let value) :
                    let respJSON = JSON(value)
                    guard let value = respJSON.array else {
                        print("Malformed data received from getRemotNews service")
                        completion(news)
                        return
                    }
                    news = value.compactMap { news in return News(json: news) }
                    completion(news)
                    return
                    
                default :
                    print("Error while fetching news: " + String(describing: response.result.error))
                    completion(news)
                    return
                }
        }
    }
}
