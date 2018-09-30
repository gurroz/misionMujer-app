//
//  Teaching+CoreDataClass.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 29/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Teaching)
public class TeachingDB: NSManagedObject {

}

extension TeachingDB {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeachingDB> {
        return NSFetchRequest<TeachingDB>(entityName: "Teaching")
    }
    
    @NSManaged public var tId: Int64
    @NSManaged public var title: String?
    @NSManaged public var tDescription: String?
    @NSManaged public var duration: Int16
    @NSManaged public var date: String?
    @NSManaged public var media: String?
    @NSManaged public var image: NSData?
    @NSManaged public var notes: String?
    @NSManaged public var type: String?
    @NSManaged public var id: UUID?
    
}
