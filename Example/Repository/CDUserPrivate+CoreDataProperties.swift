//
//  CDUserPrivate+CoreDataProperties.swift
//  
//
//  Created by Dmitriy on 04.03.2021.
//
//

import Foundation
import CoreData


extension CDUserPrivate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserPrivate> {
        return NSFetchRequest<CDUserPrivate>(entityName: "CDUserPrivate")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
}
