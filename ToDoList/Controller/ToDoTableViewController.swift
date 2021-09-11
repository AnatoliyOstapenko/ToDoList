//
//  ViewController.swift
//  ToDoList
//
//  Created by MacBook on 20.08.2021.
//

import UIKit
import RealmSwift


// change UITableViewController to SwipeTableViewController
class ToDoTableViewController: SwipeTableViewController {
    
    // initialize Realm
    let realm = try! Realm()
    
    // create array to initialize Result collection of ToDoModel struct
    var array: Results <ToDoModel>?
    
    //create Computed property to fetch information from CategoryVC
    var selectedCategory: Category? {
        didSet {
            // load last saved data
            loadData()
        }
    }
    
    @IBOutlet weak var todoSearchBar: UISearchBar!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize UISearchBarDelegate
        todoSearchBar.delegate = self


    }
    
    //MARK: - UITableViewDataSource
    
        // set numbers of rows in TableView
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return array?.count ?? 1
            
        }
        
        // update cell as SwipeTableViewController
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // create cell as a super table view from SwipeTableViewController
            let cell = super.tableView(tableView, cellForRowAt: indexPath)

            //create and unwrap item to dispatch array[indexPath.row]
            if let item = array?[indexPath.row] {
                
                // dispatch to default text label list of text from array
                cell.textLabel?.text = item.title
                
                //Ternary operator ==> instead of if let statement
                // value which has to be changed = boolean condition ? if value true : else value false
                cell.accessoryType = item.done ? .checkmark : .none
                
                // set gradient colors to cells from Chameleon Framework
                if let color = UIColor.flatNavyBlue().lighten(byPercentage: CGFloat(indexPath.row) / CGFloat(array!.count)) {
                    cell.backgroundColor = color
                    
                }

         
                
                
            } else {
                // show error on the screen
                cell.textLabel?.text = "array is nil"
            }

            return cell
        }
   
    // MARK: - UITableViewDataDelegate
    
    // It happens when user click on any row:
    
    // delegate to create an interaction UI with tableview, when user select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //create and unwrap data in row: array[indexPath.row]
        guard let item = array?[indexPath.row] else { return }
        
        // persist "done" status
        try! realm.write {
            // set opposite equation instead of if else statement
            // if "done" is true it is changed on false, and opposite
            item.done = !item.done
        }
        
        // create animated effect of deselecting row
        tableView.deselectRow(at: indexPath, animated: true)
        //update UI
        tableView.reloadData()
        
    }
    
    //MARK: - Add New Items
    
    @IBAction func addBarButtonPressed(_ sender: UIBarButtonItem) {
        
        // create var textField to capture value from closure "alert.addTextField { (alertTextField) in"
        var textField = UITextField()
        
        // create pop up alert message
        let alert = UIAlertController(title: "Add ToDo Item", message: "", preferredStyle: .alert)
        
        // add mandatory next step. create action for alert message
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //All this happens when user click on UIAlertAction button:
            
            // add item to initialize class ToDoModel
            let item = ToDoModel()
            
            // unwrap optional text from TextField
            guard let text = textField.text else { return }
            
            // assign "title" get from text field by text that user printed
            item.title = text
            
            // assign "date" get from current date
            item.date = Date()
            
            // create and unwrap new item to get selected category
            guard let newItem = self.selectedCategory else { return }

            // add new items to array (list)
            try! self.realm.write {
                    // append the given object to the end of the list
                    newItem.itemToDoModel.append(item)
                }
            
            // update UI
            self.tableView.reloadData()
        }
        
        // create action UIAlertAction button for alert message
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        // It should happen when user click on addBarButtonPressed:
        
        // create TextField in alert message to make user prints
        alert.addTextField { (alertTextField) in

            // create placeholder in TextField
            alertTextField.placeholder = "create a new item"
            
            // dispatch typed data by user to TextField
            textField = alertTextField
            
        }
        
        // attaches actions object to the alert or action sheet.
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        //activation alert and action
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Load Data
    
    // function to load data
    func loadData() {

        // Returns a Results containing the objects in the list, but sorted.
        array = selectedCategory?.itemToDoModel.sorted(byKeyPath: "date", ascending: true)

        // update UI
        tableView.reloadData()

        // hide keyboard
        tableView.endEditing(true)
    }
    
    // MARK: - Delete Data From Swipe
    
    // use function from SwipeTableViewController
    override func deleteBySwiping(at indexPath: IndexPath) {
        
        //create and unwrap data in row: array[indexPath.row]
        guard let item = self.array?[indexPath.row] else { return }
        
        // delete row from Realm and from screen
        try! self.realm.write {
            self.realm.delete(item)
        }
    }

}

// MARK: - UISearchBarDelegate protocol

extension ToDoTableViewController: UISearchBarDelegate {
    
    // It happens when user clicked search button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // unwrap text from search bar
        guard let text = searchBar.text else { return }
        
        // Returns matching object with text user printed from array. sorted by ascending
        array = array?.filter("title CONTAINS[cd] %@", text).sorted(byKeyPath: "date", ascending: true)
        
        // update UI
        tableView.reloadData()


    }
    // It happens when text is cleared from the search text field
    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {

        // it triggered when search bar is clear after typing
        if searchBar.text?.count == 0 {

            loadData()

            
            DispatchQueue.main.async {
                //
                searchBar.resignFirstResponder()
            }
            
        }

    }



}




