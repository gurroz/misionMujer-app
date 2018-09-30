//
//  CategoryHandler.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 1/10/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
protocol CategoryHandler {
    init(nextHandler: CategoryHandler?)
    func getCategories(onCompleted: (([Category]?) -> ())?)
}
