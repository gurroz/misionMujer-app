//
//  CategoriesDB.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 29/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CategoriesDB)
public class CategoriesDB: NSManagedObject {

}
extension CategoriesDB {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoriesDB> {
        return NSFetchRequest<CategoriesDB>(entityName: "CategoriesDB")
    }
    
    @NSManaged public var categoryId: Int16
    @NSManaged public var title: String?
    @NSManaged public var teaching: TeachingDB?
    
}
