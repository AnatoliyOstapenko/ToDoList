//
//  SwipeTableViewController.swift
//  ToDoList
//
//  Created by MacBook on 09.09.2021.
//

import UIKit
import SwipeCellKit



class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
    // create function to use in CategoryTableViewController
    func deleteBySwiping (at indexPath: IndexPath) {

    }

    
}
