//
//  TeachingCache.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 30/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
class TeachingCache: TeachingHandler {
    private var teachings: [Int64: Teaching] = [:];
    private var nextHandler: TeachingHandler
    
    required init(nextHandler: TeachingHandler?){
        self.nextHandler = nextHandler!
    }
    
    func getTeaching(_ id: Int64, onCompleted: ((Teaching?) -> ())?) {
        if let teaching: Teaching = self.teachings[id] {
            onCompleted?(teaching)
        } else {
            nextHandler.getTeaching(id) { teaching in
                if teaching != nil {
                    self.teachings.updateValue(teaching!, forKey: teaching!.id)
                }
                onCompleted?(teaching)
            }
        }
    }
    
    func getAllTeachings(onCompleted: (([Teaching]?) -> ())?) {
        let teachingList: [Teaching] =  Array(self.teachings.values)
        if teachingList.count > 0 {
            onCompleted?(teachingList)
        } else {
            nextHandler.getAllTeachings() { teachings in
                if teachings != nil {
                    for teaching in teachings! {
                        self.teachings.updateValue(teaching, forKey: teaching.id)
                    }
                }
                onCompleted?(teachings)
            }
        }
    }
    
    func saveTeachingData(teaching: Teaching) {
        teachings.updateValue(teaching, forKey: teaching.id)
    }
    
    
}
