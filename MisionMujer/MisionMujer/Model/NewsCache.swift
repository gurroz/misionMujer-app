//
//  NewsCache.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 30/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class NewsCache: NewsHandler {
    private var news: [News]
    private var nextHandler: NewsHandler
    
    required init(nextHandler: NewsHandler?) {
        self.nextHandler = nextHandler!
        self.news = [News]()
    }
    
    func getAllNews(onCompleted: (([News]?) -> ())?) {
        if self.news.count > 0 {
            onCompleted?(self.news)
        } else {
            nextHandler.getAllNews() { news in
                if news != nil {
                    self.news = news!
                }
                onCompleted?(news)
            }
        }
    }
   
    
}
