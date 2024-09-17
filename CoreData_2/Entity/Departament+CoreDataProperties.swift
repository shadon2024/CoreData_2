//
//  Departament+CoreDataProperties.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//
//

import Foundation
import CoreData


extension Departament {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Departament> {
        return NSFetchRequest<Departament>(entityName: "Departament")
    }

    @NSManaged public var nameDep: String?

}

extension Departament : Identifiable {

}
