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
    let itemArray = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

//MARK: - UITableViewDataSource

extension ToDoTableViewController: UITableViewDataSource {
    
    // set numbers of rows in TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    // set cell and changing UI by TableViewCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create message to get acces to row in Table View
        let item = itemArray[indexPath.row]
        
        // Returns a reusable table-view cell object as! MessageCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoTableViewController
        
        
        return cell
        
        
    }
}

