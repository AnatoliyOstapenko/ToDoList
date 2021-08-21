//
//  ViewController.swift
//  ToDoList
//
//  Created by MacBook on 20.08.2021.
//

import UIKit

// change UIViewController to UITableViewController
class ToDoTableViewController: UITableViewController {

    
    // create array to use in table
    let itemArray: [String] = [
        "one of the very few fiction films about Nazi",
        "principally Witold Lesiewicz",
        "The film’s self-questioning of its dramatic",
        "Auschwitz from the point of view of a Nazi official"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registers a class for use in creating new table cells.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoCell")

    }
    //MARK: - UITableViewDataSource
    
        // set numbers of rows in TableView
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return itemArray.count
            
        }
        
        // ask for the data source for a cell to insert in a particular location of the table view
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // create proper item to get acces to row in Table View
            let item = itemArray[indexPath.row]
            
            // Return a reusable table view cell object as! MessageCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
            
            cell.textLabel?.text = "String(item[0])"


            return cell
            
            
        }
    
}




