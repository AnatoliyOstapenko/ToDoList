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
    
    
    @IBOutlet weak var todoSearchBar: UISearchBar!
    
    
    // create array to initialize for using in table view
    var itemArray = [ToDoModel]()
    
    //create Computed property to fetch information from CategoryVC
    var selectedCategory: Category? {
        didSet {
            
            // load last saved data from Core Data
//            loadData()
        }
    }

    
    // initialize context CoreData from AppDelegate to interact with View Controller
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // switch to Light Mode screen (avoid dark background table view)
        overrideUserInterfaceStyle = .light
        
        // initialize UISearchBarDelegate
//        todoSearchBar.delegate = self

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
   
    // MARK: - UITableViewDataDelegate
    
    // It happens when user click on any row:
    
    // delegate to create an interaction UI with tableview, when user select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //create item to dispatch itemArray[indexPath.row]
        let item = itemArray[indexPath.row]

//        // remove row from Core Data
//        context.delete(item)
//
//        // remove row from array
//        itemArray.remove(at: indexPath.row)
        
        // set opposite equation instead of if else statement
        // if "done" is true it is changed on false, and opposite
        item.done = !item.done
        
        // save data in Core Data
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
            
            //All this happens when user click on UIAlertAction button:
            
//            //set a new item to initialize public class ToDoModel from CoreData and transfer context
//            let item = ToDoModel(context: self.context)
//
//            // unwrap optional text from TextField
//            guard let newItem = textField.text else { return }
//
//            //assign "title" get from text field by newItem what user printed
//            item.title = newItem
//
//            //assign "done" false by default
//            item.done = false
//
//            //assign relationships in Core Data
//            item.parentCategory = self.selectedCategory
//
//            // add new printed text further that user type to array
//            self.itemArray.append(item)

            // save data
            self.saveData()

        }
        
        // It should happen when user click on addBarButtonPressed:
        
        // create TextField in alert message to make user prints
        alert.addTextField { (alertTextField) in

            // create placeholder in TextField
            alertTextField.placeholder = "create a new item"
            
            // dispatch typed data by user to TextField
            textField = alertTextField
            
        }
        
        // attaches an action object to the alert or action sheet.
        alert.addAction(action)
        
        //activation alert and action
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Realm Data
    
    // function to save data locally
    func saveData() {

        do {
            try context.save()
        } catch { print(error.localizedDescription) }
        
        tableView.reloadData()
        
    }
    
//    // function to load data
//    func loadData(with request: NSFetchRequest <ToDoModel> = ToDoModel.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        // compare text with "name" in Core Data
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate ,additionalPredicate])
//
//        } else {
//
//            request.predicate = categoryPredicate
//        }
//
//        // retrive data request
//        do {
//            itemArray = try context.fetch(request)
//        } catch { print(error.localizedDescription) }
//
//        // update UI
//        tableView.reloadData()
//
//        // hide keyboard
//        tableView.endEditing(true)
//
//    }
//
}

// MARK: - UISearchBarDelegate protocol

//extension ToDoTableViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        // create request to retrieve data from a persistent store
//        let request: NSFetchRequest <ToDoModel> = ToDoModel.fetchRequest()
//
//        // unwrap text from search bar that was typed by user
//        guard let text = searchBar.text else { return }
//
//        //compare text from search bar with "title" Core Data
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
//
//        // create property to arrange "title" by ascending
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        // retrieve data by request
//        loadData(with: request, predicate: predicate)
//
//        // reload UI
//        tableView.reloadData()
//
//    }
//    // It happens when text is cleared from the search text field
//    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
//
//        // it triggered when search bar is clear after typing
//        if searchBar.text?.count == 0 {
//
//            loadData()

            //
//            DispatchQueue.main.async {
//                //
//                searchBar.resignFirstResponder()
//            }
            
//        }
//
//    }
//
//
//
//}




