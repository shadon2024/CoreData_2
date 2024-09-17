//
//  ViewController.swift
//  CoreData_2
//
//  Created by Admin on 09.09.2024.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // app to in apdelegate
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Create context
        //let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Описание сущности
        //let entityDescreption = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        // Создание обьекта
        //let managedObject = Person(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)
        let managedObject = Person()
        
        
        // Установка значения атрибута
        managedObject.name = "Shodon"
        managedObject.age = 32
        
        // извлекаем значение атрибута
        let name = managedObject.name
        let age = managedObject.age
        
        
        //print("\(name), \(age)")
        print("\(name ?? "0"), \(age)")
        
        // Сохранение данных
        //appDelegate.saveContext()
        CoreDataManager.instance.saveContext()
        
        
        // Извлекаем данные
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                //print("name - \(result.name), age - \(result.age)")
                print("name - \(result.name ?? "0"), age - \(result.age)")
            }
        } catch {
                    print(error)
        }
        
        // Удаление всех записи
//        do {
//            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
//            for result in results as! [NSManagedObject] {
//                CoreDataManager.instance.context.delete(result)
//            }
//        } catch {
//            print(error)
//        }
//
//        // Сохранить
//        CoreDataManager.instance.saveContext()
        }
        
        
    }
    


