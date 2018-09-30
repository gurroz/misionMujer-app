//
//  Categories+CoreDataClass.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 29/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Categories)
public class CategoriesDB: NSManagedObject {

}
extension CategoriesDB {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoriesDB> {
        return NSFetchRequest<CategoriesDB>(entityName: "Categories")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var challengeId: Int16
    @NSManaged public var title: String?
    @NSManaged public var idTeaching: TeachingDB?
    
}
