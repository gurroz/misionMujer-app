//
//  StatisticsDB.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 29/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StatisticsDB)
public class StatisticsDB: NSManagedObject {

}

extension StatisticsDB {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatisticsDB> {
        return NSFetchRequest<StatisticsDB>(entityName: "StatisticsDB")
    }
    
    @NSManaged public var views: Int32
    @NSManaged public var lastViewDuration: Int32
    @NSManaged public var teaching: TeachingDB?
    
}
