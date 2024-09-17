//
//  Person+CoreDataClass.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
    //вспомогателный инциализатор
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)
    }

}
