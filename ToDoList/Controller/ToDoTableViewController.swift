//
//  ViewController.swift
//  ToDoList
//
//  Created by MacBook on 20.08.2021.
//

import UIKit
import CoreData


// change UIViewController to UITableViewController (UITableViewDataSource and UITableViewDelegate included)
class ToDoTableViewController: UITableViewController {
    
    // create array to initialize for using in table view
    var itemArray = [ToDoModel]()

    
    //intialize File Manager to interact with the file system (save and load data)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoModel.plist")
    
    // create context CoreData from AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load last saved data from local resources
//        loadData()
        // switch to Light Mode screen (avoid dark background table view)
        overrideUserInterfaceStyle = .light

    }
    
    //MARK: - UITableViewDataSource
    
        // set numbers of rows in TableView
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
            
        }
        
        // ask for the data source for a cell to insert in a particular location of the table view
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
            
            //create item to dispatch itemArray[indexPath.row]
            let item = itemArray[indexPath.row]
            
            // dispatch to default text label list of text from array
            cell.textLabel?.text = item.title
            
            //Ternary operator ==> instead of if let statement
            // value which has to be changed = condition ? if value true : else value false
            cell.accessoryType = item.done ? .checkmark : .none
            
            return cell
        }
   
    //MARK: - UITableViewDataDelegate
    
    // delegate to create an interaction UI with tableview, when user select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //create item to dispatch itemArray[indexPath.row]
        let item = itemArray[indexPath.row]
        
        // set opposite equation instead of if else statement
        // if "done" is true it is changed on false, and opposite
        item.done = !item.done
        
        // save data locally
        saveData()
        
        // create animated effect of deselecting row
        tableView.deselectRow(at: indexPath, animated: true)
   
    }
    
    //MARK: - Add New Items
    
    @IBAction func addBarButtonPressed(_ sender: UIBarButtonItem) {
        
        // create var textField to capture value from closure "alert.addTextField { (alertTextField) in"
        var textField = UITextField()
        
        // create pop up alert message
        let alert = UIAlertController(title: "Add ToDo Item", message: "", preferredStyle: .alert)
        
        // add mandatory next step. create action for alert message
        let action = UIAlertAction(title: "\u{2705}", style: .default) { (action) in
            
            // MARK: - All this happens when user click on UIAlertAction button
            
            //set a new item to initialize public class ToDoModel from CoreData and transfer context
            let item = ToDoModel(context: self.context)
            
            // unwrap optional text from TextField
            guard let newItem = textField.text else { return }
            
            //assign "title" get from text field by newItem what user printed
            item.title = newItem
            
            //assign "done" false by default
            item.done = false
            
            // add new printed text further that user type to array
            self.itemArray.append(item)
            
            // update UI so that the appended item appears
            self.tableView.reloadData()
            
            // save data
            self.saveData()

        }
        
        // MARK: - It should happen when user click on addBarButtonPressed
        // create TextField in alert message to make user prints
        alert.addTextField { (alertTextField) in

            // create placeholder in TextField
            alertTextField.placeholder = "create a new item"
            textField = alertTextField
            
        }
        
        // attaches an action object to the alert or action sheet.
        alert.addAction(action)
        
        //activation alert and action
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Model Manipulation Methods
    
    // function to save data locally
    func saveData() {

        do {
            try context.save()
        } catch { print(error.localizedDescription) }

        
        
    }
    // function to load data from local data source (Decodable protocol)
//    func loadData() {
//
//        // function to load data locally
//        do {
//            let data = try Data(contentsOf: dataFilePath!)
//            let decoder = PropertyListDecoder()
//            itemArray = try decoder.decode([ToDoModel].self, from: data)
//
//        } catch { print(error.localizedDescription)}
//
//
//    }
    
    
}




