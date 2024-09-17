//
//  Comments+CoreDataClass.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//
//

import Foundation
import CoreData

@objc(Comments)
public class Comments: NSManagedObject {
    
    //вспомогателный инциализатор
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)
    }

}
