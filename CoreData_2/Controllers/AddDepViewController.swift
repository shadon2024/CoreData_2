//
//  addDepViewController.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//

import UIKit

class AddDepViewController: UIViewController {

    var departament: Departament?
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func save(_ sender: Any) {
            if saveDepartament() {
                dismiss(animated: true, completion: nil)
            }
    }
    
    
    @IBOutlet weak var nameDepTextFild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Чтение объекта
        if let departament = departament {
            nameDepTextFild.text = departament.nameDep
        }
        nameDepTextFild.delegate = self
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        //showSelectionAlert()
//        return true // Отключает стандартное поведение текстового поля (открытие клавиатуры)
//    }
    
//    func showSelectionAlert() {
//        let alertController = UIAlertController(title: "Выберите опцию", message: nil, preferredStyle: .actionSheet)
//
//        let options = ["Опция 1", "Опция 2", "Опция 3"] // Ваши опции
//
//        for option in options {
//            let action = UIAlertAction(title: option, style: .default) { [weak self] _ in
//                self?.nameDepTextFild.text = option
//            }
//            alertController.addAction(action)
//        }
//
//        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        present(alertController, animated: true, completion: nil)
//    }

    func saveDepartament() -> Bool {
        if nameDepTextFild.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка ввода", message: "Вы не запнили поле ОТДЕЛ - сохранение не возможно" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        // Создаем объект
        if departament == nil {
            departament = Departament()
        }
        
        // Сохранить объект
        if let depart = departament {
            depart.nameDep = nameDepTextFild.text
            //person.age = Int16(ageTexxtField.text!)!
            //person.departament = department.text
            CoreDataManager.instance.saveContext()
            
        }
        
        return true
    }


}


extension AddDepViewController: UITextFieldDelegate {
    
}
