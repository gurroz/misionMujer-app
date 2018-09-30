//
//  NewsService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation

class NewsService {

    static let sharedInstance = NewsService()
    private let newsHandler: NewsHandler
    
    private init() {
        let newsApiHandler = NewsAPI(nextHandler: nil)
        newsHandler = NewsCache(nextHandler: newsApiHandler)
    }
    
    func getDefaulNews() -> News {
        return News()!
    }
    
    func getNewsList(completion: (([News]?) -> ())?) -> Void {
        newsHandler.getAllNews(onCompleted: completion)
    }
}
