//
//  addViewController.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    struct Constans {
        static let entity = "Departament"
        static let sortNameDep = "nameDep"
    }
    
    var fetchResultController = CoreDataManager.instance.fetchResultController(entityName: Constans.entity, sortName: Constans.sortNameDep)
    
    var person: Person?
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
        if savePerson() {
            dismiss(animated: true, completion: nil)
        }
    }
    

    @IBOutlet weak var nameTexxtField: UITextField!
    @IBOutlet weak var ageTexxtField: UITextField!
    
    @IBOutlet weak var department: UITextField! {
        didSet {
            department.inputView = UIView(frame: .zero)
            department.addTarget(self, action: #selector(editingDep), for: .editingDidBegin)
        }
    }
    
    
    
    
    @IBOutlet weak var commentTextField: UITextField!
    

    var options: [String] = []


    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showSelectionAlert()
        return false // Отключает стандартное поведение текстового поля (открытие клавиатуры)
    }

    func showSelectionAlert() {
        let alertController = UIAlertController(title: "Выберите опцию", message: nil, preferredStyle: .actionSheet)

        // Используем опции, загруженные из Core Data
        for option in options {
            let action = UIAlertAction(title: option, style: .default) { [weak self] _ in
                self?.department.text = option
            }
            alertController.addAction(action)

        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    // Метод для загрузки данных из Core Data
        func loadOptionsFromCoreData() {
            guard UIApplication.shared.delegate is CoreDataManager else { return }

            let managedContext = CoreDataManager.instance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Departament")

            do {
                let fetchedOptions = try managedContext.fetch(fetchRequest)
                options = fetchedOptions.compactMap { $0.value(forKey: "nameDep") as? String }
                
                // Выводим массив для отладки
                        print("Загруженные департаменты: \(options)")
                        
                        // Если опции пусты, покажем сообщение для отладки
                        if options.isEmpty {
                            print("Нет данных в Core Data")
                        }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    
    func deleteAllData(entity: String) {
        let managedContext = CoreDataManager.instance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            print("\(entity) сущность успешно удалена.")
        } catch let error as NSError {
            print("Ошибка при удалении данных: \(error), \(error.userInfo)")
        }
    }
    
    
//    @IBOutlet weak var department: UITextField! {
//        didSet {
//            department.inputView = UIView(frame: .zero)
//            department.addTarget(self, action: #selector(editingDep), for: .editingDidBegin)
//        }
//    }
//
//
    @objc func editingDep() {
        let alert = UIAlertController(title: "Выберите отдел ", message: nil, preferredStyle: .actionSheet)
        let numberDepartament = fetchResultController.sections![0].numberOfObjects

        if numberDepartament != 0 {
            for item in 0...numberDepartament - 1 {
                let departament = fetchResultController.object(at: [0, item]) as! Departament
                alert.addAction(UIAlertAction(title: departament.nameDep, style: .default, handler: { [unowned self] _ in
                    self.textDep = departament.nameDep!
                    department.resignFirstResponder()

                }))
            }
        } else {
            alert.addAction(UIAlertAction(title: "?", style: .default, handler: { [unowned self] _ in
                self.textDep = ""
                department.resignFirstResponder()
            }))

            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { [unowned self] _ in
                department.resignFirstResponder()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Наблюдатель
    var textDep: String? {
        didSet {
            department.text = textDep
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        department.delegate = self
        //deleteAllData(entity: Constans.entity)
        loadOptionsFromCoreData()
        //seedDataIfNeeded()
        
        // Чтение объекта
        if let person = person {
            nameTexxtField.text = person.name
            ageTexxtField.text = String(person.age)
            department.text = person.departament
        }
        
        // Загрузить данные в Controller
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }


    }
    
    
    func savePerson() -> Bool {
        if nameTexxtField.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка ввода", message: "Вы не запнили поле ФАМИЛИЯ - сохранение не возможно" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        // Создаем объект
        if person == nil {
            person = Person()
        }
        
        // Сохранить объект
        if let person = person {
            person.name = nameTexxtField.text
            person.age = Int16(ageTexxtField.text!)!
            person.departament = department.text
            CoreDataManager.instance.saveContext()
            
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddViewController: UITextFieldDelegate {
    
}
