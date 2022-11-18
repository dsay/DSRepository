//
//  CDUser+CoreDataProperties.swift
//  
//
//  Created by Dmitriy on 04.03.2021.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
