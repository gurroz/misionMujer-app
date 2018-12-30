//
//  TeachingAPI.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 30/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TeachingAPI: TeachingHandler {
    let session = URLSession.shared
    let TEACHING_URL = Configurations.baseURL + "teachings/"
        
    required init(nextHandler: TeachingHandler?) {}
    
    func getTeaching(_ id: Int64, onCompleted: ((Teaching?) -> ())?) {
        onCompleted!(nil) // TODO: Implement individual Teaching API
    }
    
    func getAllTeachings(onCompleted: (([Teaching]?) -> ())?) {
        self.getRemoteTeachings(completion: onCompleted!)
    }
    
    private func getRemoteTeachings(completion:  @escaping ([Teaching]) -> Void) {
        var teachings:[Teaching] = [Teaching]()
        
        guard let url = URL(string: TEACHING_URL) else {
            completion(teachings)
            return
        }
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success(let value) :
                    let respJSON = JSON(value)
                    guard let value = respJSON.array else {
                        print("Malformed data received from getRemoteTeachings service")
                        completion(teachings)
                        return
                    }
                    teachings = value.compactMap { teaching in return Teaching(json: teaching) }
                    completion(teachings)
                    return
                    
                default :
                    print("Error while fetching teachings: " + String(describing: response.result.error))
                    completion(teachings)
                    return
                }
        }
    }
    
    // Does not apply
    func saveTeachingData(teaching: Teaching) {
    }
    
}
