//
//  SwipeTableViewController.swift
//  ToDoList
//
//  Created by MacBook on 09.09.2021.
//

import UIKit
import SwipeCellKit
import ChameleonFramework



class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // switch to Light Mode screen (avoid dark background table view)
        overrideUserInterfaceStyle = .light
        
        // change height of row to 80
        tableView.rowHeight = 80
        
        // delete separator line between cells
        tableView.separatorStyle = .none
        
        // change bar tint of navigation bar
        navigationController?.navigationBar.barTintColor = FlatNavyBlue()
    }
    //MARK: - UITableViewDataSource
    
    // create cell as SwipeTableViewController
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self

        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    // grab it from https://github.com/SwipeCellKit/SwipeCellKit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
               
                // delete action happens here
                self.deleteBySwiping(at: indexPath)

            }

            // customize the action appearance
            deleteAction.image = UIImage(named: "delete")

            return [deleteAction]
    }
    // to customize the behavior of the swipe actions:
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        
        // delete row to do one swipe
        options.expansionStyle = .destructive
        
        return options
    }
    
    // create function to use in other TableViewController
    func deleteBySwiping (at indexPath: IndexPath) {

    }

    
}
