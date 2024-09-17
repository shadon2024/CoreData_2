//
//  MyTableViewController.swift
//  CoreData_2
//
//  Created by Admin on 12.09.2024.
//

import UIKit
import CoreData

class MyTableViewController: UITableViewController {
    
    struct Constants {
        static let entity = "Person"
        static let sortName = "name"
        static let cellName = "Cell"
        static let identifier = "tabeleInAddVC"
    }
    
    var fetchResultController = CoreDataManager.instance.fetchResultController(entityName: Constants.entity, sortName: Constants.sortName)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultController.delegate = self
        
        // Удаляем кэш перед выполнением запроса данных
            NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
        
        // Удаляем разлиновку пустых ячеек
        tableView.tableFooterView = UIView()
        
        // Сделаем загаловки большим
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        //tableView.delegate = self
        //tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.setNeedsLayout()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchResultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)

        let person = fetchResultController.object(at: indexPath) as! Person
        cell.textLabel?.text = person.name
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        cell.detailTextLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        cell.detailTextLabel?.text = String(person.age)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = fetchResultController.object(at: indexPath) as! Person
        performSegue(withIdentifier: Constants.identifier, sender: person)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let person = fetchResultController.object(at: indexPath) as! Person
            CoreDataManager.instance.context.delete(person)
            CoreDataManager.instance.saveContext()
        }
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.identifier {
            let controller = segue.destination as! AddViewController
            controller.person = sender as? Person
        }
    }
    

}


extension MyTableViewController: NSFetchedResultsControllerDelegate {
    
    // Информирует о начале изменения данных
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let person = fetchResultController.object(at: indexPath) as! Person
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = person.name
                cell?.detailTextLabel?.text = String(person.age)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        @unknown default:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
