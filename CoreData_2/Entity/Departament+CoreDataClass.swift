//
//  Departament+CoreDataClass.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//
//

import Foundation
import CoreData

@objc(Departament)
public class Departament: NSManagedObject {

    //вспомогателный инциализатор
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Departament"), insertInto: CoreDataManager.instance.context)
    }
}
