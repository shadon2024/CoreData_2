//
//  Comments+CoreDataProperties.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//
//

import Foundation
import CoreData


extension Comments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comments> {
        return NSFetchRequest<Comments>(entityName: "Comments")
    }

    @NSManaged public var comments: String?
    @NSManaged public var comment: Person?

}

extension Comments : Identifiable {

}
