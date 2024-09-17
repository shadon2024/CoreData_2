//
//  Person+CoreDataProperties.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var departament: String?
    @NSManaged public var age: Int16
    @NSManaged public var person: Comments?

}

extension Person : Identifiable {

}
