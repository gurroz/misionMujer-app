//
//  Statistics+CoreDataClass.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 29/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Statistics)
public class StatisticsDB: NSManagedObject {

}

extension StatisticsDB {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatisticsDB> {
        return NSFetchRequest<StatisticsDB>(entityName: "Statistics")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var teachingId: Int16
    @NSManaged public var views: Int32
    @NSManaged public var lastViewDuration: Int32
    @NSManaged public var idTeaching: TeachingDB?
    
}
