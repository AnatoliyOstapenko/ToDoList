//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by MacBook on 30.08.2021.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryTableViewController: UITableViewController {

    
    // initialize Realm
    let realm = try! Realm()
    
    
    // create array to initialize Result collection of Category struct
    var array: Results <Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // load last saved data
        loadData()
        
        // switch to Light Mode screen (avoid dark background table view)
        overrideUserInterfaceStyle = .light
    }

    //MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // array is optional so it has to be unwrap by coalascing method
        return array?.count ?? 1
    }
    
//    // create cell from SwipeTableVC
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    // update cell as SwipeTableVC
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell

        //create item to dispatch array[indexPath.row]
        if let item = array?[indexPath.row] {

            // dispatch to default text label list of text from array
            cell.textLabel?.text = item.name
        } else { print("error with cell") }
        
        cell.delegate = self

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
   
    }
    
    
    
    // MARK: - UIStoryboardSegue prepare
    
    // prepare before switch on the next UI screen (to transfer data from current VC to the next VC)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // create destinationVC to declare it as ToDoTableViewController
        let destinationVC = segue.destination as! ToDoTableViewController
        
        //unwrap index path for selected row
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // dispatch data to selectedCategory in ToDoTableVC
        destinationVC.selectedCategory = array?[indexPath.row]
        
       
    }

    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // create var textField to capture value from closure "alert.addTextField { (alertTextField) in"
        var textField = UITextField()
        
        // create pop up alert message
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        // create UIAlertAction Button for alert message
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // All this happens when user click on UIAlertAction button:
            
            //set a new item to initialize class
            let item = Category()
            
            // unwrap optional text from TextField
            guard let text = textField.text else { return }
            
            //assign "name" getting from text field that user printed
            item.name = text

            // save data
            self.saveData(category: item)

        }
        // create action UIAlertAction button for alert message
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        // It should happen when user click on addButtonPressed
        // create TextField in alert message to make user prints
        alert.addTextField { (alertTextField) in

            // create placeholder in TextField
            alertTextField.placeholder = "create a new category"
            
            // dispatch typed data by user to TextField
            textField = alertTextField
            
        }
        
        // attaches all of UIAlertAction objects to the alert
        alert.addAction(addButton)
        alert.addAction(cancelButton)

        //activation alert
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Realm Data
    
    // function to save data locally
    func saveData(category: Category) {
        
        // add data
        try! realm.write {
            realm.add(category)
        }
        
        // reload UI on screen
        tableView.reloadData()
        
    }
    
    // function to load data
    func loadData() {
        
        // Returns all objects of the given type stored in the Realm
        array = realm.objects(Category.self)
        
        // reload UI on screen
        tableView.reloadData()
    }
    

}
            
  //MARK:- SwipeTableViewCellDelegate protocol

extension CategoryTableViewController: SwipeTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        <#code#>
    }
    
    
}
    

