//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by MacBook on 30.08.2021.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    // create array to initialize Core Data
    var array = [Category]()

    
    // initialize context Core Data from AppDelegate to interact with View Controller
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // load last saved data from Core Data
        loadData()
        
        // switch to Light Mode screen (avoid dark background table view)
        overrideUserInterfaceStyle = .light
    }

    //MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        //create item to dispatch array[indexPath.row]
        let item = array[indexPath.row]
        
        // dispatch to default text label list of text from array
        cell.textLabel?.text = item.name

        return cell
    }
    
    // MARK: - UITableViewDataDelegate
    
    // It happens when user click on any row:
    
    // delegate to create an interaction UI with tableview, when user select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //switch on the next UI screen by segue
        performSegue(withIdentifier: "goToTDTableVC", sender: self)
        
        // create animated effect of deselecting row
        tableView.deselectRow(at: indexPath, animated: true)
        
        
//        //create item to dispatch itemArray[indexPath.row]
//        let item = array[indexPath.row]
        
//        // remove row from Core Data
//        context.delete(item)
//
//        // remove row from array
//        array.remove(at: indexPath.row)
        
        // save data in Core Data
        saveData()
        
        
   
    }
    // prepare before switch on the next UI screen (to transfer data from current VC to the next VC)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // create destinationVC to declare it as ToDoTableViewController
        let destinationVC = segue.destination as! ToDoTableViewController
        
        //unwrap index path for selected row
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        //
        destinationVC.selectedCategory = array[indexPath.row]
        
       
    }

    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // create var textField to capture value from closure "alert.addTextField { (alertTextField) in"
        var textField = UITextField()
        
        // create pop up alert message
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        // add mandatory next step. create action for alert message
        let action = UIAlertAction(title: "append", style: .default) { (action) in
            
            // All this happens when user click on UIAlertAction button:
            
            //set a new item to initialize public class from CoreData and transfer context
            let item = Category(context: self.context)
            
            // unwrap optional text from TextField
            guard let text = textField.text else { return }
            
            //assign "name" getting from text field that user printed
            item.name = text
            
            // add new printed text further that user type to array
            self.array.append(item)

            // save data
            self.saveData()

        }
        
        // It should happen when user click on addButtonPressed
        // create TextField in alert message to make user prints
        alert.addTextField { (alertTextField) in

            // create placeholder in TextField
            alertTextField.placeholder = "create a new category"
            
            // dispatch typed data by user to TextField
            textField = alertTextField
            
        }
        
        // attaches an action object to the alert or action sheet.
        alert.addAction(action)
        
        //activation alert and action
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Core Data
    
    // function to save data locally
    func saveData() {

        do {
            try context.save()
        } catch { print(error.localizedDescription) }
        
        tableView.reloadData()
        
    }
    
    // function to load data from Core Data
    func loadData(with request: NSFetchRequest <Category> = Category.fetchRequest()) {
        
        // retrive data request
        do {
            array = try context.fetch(request)
        } catch { print(error.localizedDescription) }
        
        // update UI
        tableView.reloadData()
        
        // hide keyboard
        tableView.endEditing(true)

    }
    

}
            
        
    

