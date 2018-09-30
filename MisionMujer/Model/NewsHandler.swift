//
//  NewsHandler.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 30/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
protocol NewsHandler {
    init(nextHandler: NewsHandler?)
    func getAllNews(onCompleted: (([News]?) -> ())?)
}
