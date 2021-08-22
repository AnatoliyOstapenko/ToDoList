//
//  ViewController.swift
//  ToDoList
//
//  Created by MacBook on 20.08.2021.
//

import UIKit

// change UIViewController to UITableViewController (UITableViewDataSource and UITableViewDelegate included)
class ToDoTableViewController: UITableViewController {
    
    // create defaults to use data persistence
    let defaults = UserDefaults.standard

    
    // create array to use in table view
    var itemArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrieve a last data (array) after closing app from local data persistence
        if let savedData = defaults.array(forKey: "ToDoKey") as? [String] {
            itemArray = savedData
        }

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
            
            // create item to get acces to row in itemArray of Table View
            let item = itemArray[indexPath.row]
            
            // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
            
            // dispatch to default text label list of text from array
            cell.textLabel?.text = item
            return cell
            
            
        }
   
    //MARK: - UITableViewDataDelegate
    
    // delegate to create an interaction UI with tableview, when user select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row: \(itemArray[indexPath.row])")

        
        // create let call to unwrap optional cellForRow
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        // set a mark accessory when user toggles a row and unmark when user untoggle a row
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }

        
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
            
            // All this happens when user click on button
            // unwrap optional text from TextField
            guard let newItem = textField.text else {
                return
            }
            // add new item that user type to array
            self.itemArray.append(newItem)
            
            // save last list of array properties
            self.defaults.set(self.itemArray, forKey: "ToDoKey")
            
            // update array - reload data in table view to add a new row
            self.tableView.reloadData()

        }
        
        // create TextField in alert message to make user prints
        alert.addTextField { (alertTextField) in

            // create placeholder in TextField
            alertTextField.placeholder = "create a new item"
            textField = alertTextField
            
//            guard let item = alertTextField.text else {
//                return
//            }
//
//            // create Capture Value to get value from closure
//            func getNewItem() -> String {
//                return item
//            }
//            return getNewItem()
        }
        
        // attaches an action object to the alert or action sheet.
        alert.addAction(action)
        
        //activation alert and action
        present(alert, animated: true, completion: nil)
        
    }
    
}




