//
//  ViewController.swift
//  ToDoList
//
//  Created by MacBook on 20.08.2021.
//

import UIKit

// change UIViewController to UITableViewController (UITableViewDataSource and UITableViewDelegate included)
class ToDoTableViewController: UITableViewController {
    
    // create array to initialize for using in table view
    var itemArray = [ToDoModel]()
    
    // create defaults to use data persistence
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //activate ToDoModel
        var newItem = ToDoModel()
        newItem.title = "First Line"
        newItem.done = true
        itemArray.append(newItem)
        
        var newItem2 = ToDoModel()
        newItem2.title = "Second Line"
        newItem2.done = false
        itemArray.append(newItem2)
        
        
//        //retrieve a last data from array after closing app from local data persistence
//        if let item = defaults.array(forKey: "ToDoKey") as? [String] {
//
//            //dispatch data to array
//            itemArray = item
//    }

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
            
            // create item to get acces to row in itemArray of Table View
            let item = itemArray[indexPath.row]
            
            // dispatch to default text label list of text from array
            cell.textLabel?.text = item.title
            
            // set a mark accessory when user toggles a row and unmark when user untoggle a row
            if item.done == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
        }
   
    //MARK: - UITableViewDataDelegate
    
    // delegate to create an interaction UI with tableview, when user select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // retrieve "done" from array by ToDoModel
        var item = itemArray[indexPath.row].done
        
        //change "done" on true or false when user select a row
        if item == false {
            item = true
        } else {
            item = false
        }
        
        // reload data in table view to change "done"
        tableView.reloadData()
        
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
            
            // MARK: - All this happens when user click on button
            // unwrap optional text from TextField
            guard let newItem = textField.text else {
                return
            }
            
            //set a new item to initialize struct ToDoModel
            var toDoModel = ToDoModel()
            
            //get from text field by newItem what user printed
            toDoModel.title = newItem
            
            // add new printed text further that user type to array
            self.itemArray.append(toDoModel)
            
            // save last data (array properties)
            self.defaults.set(self.itemArray, forKey: "ToDoKey")
            
            // update array - reload data in table view to add a new row
            self.tableView.reloadData()

        }
        
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
    
}



