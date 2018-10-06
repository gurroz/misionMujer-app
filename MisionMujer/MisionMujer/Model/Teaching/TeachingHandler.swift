//
//  TeachingHandler.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 30/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
protocol TeachingHandler {
    init(nextHandler: TeachingHandler?)
    func getTeaching(_ id: Int64, onCompleted: ((Teaching?) -> ())?)
    func getAllTeachings(onCompleted: (([Teaching]?) -> ())?)
    func saveTeachingData(teaching: Teaching)
}
