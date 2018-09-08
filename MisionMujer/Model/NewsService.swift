//
//  NewsService.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class NewsService {
    let newsDictonary:[String: News]
    
    static let sharedInstance = NewsService()
    
    private init() {
        newsDictonary = News.getNewsDictionary()
    }

    func getNewsDictionary() -> [String: News] {
        return newsDictonary;
    }
    
    func getNewsList() -> [News] {
        return Array(newsDictonary.values);
    }
    
}
