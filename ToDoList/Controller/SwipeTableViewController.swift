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
    
    // grab it from https://github.com/SwipeCellKit/SwipeCellKit
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                print("delete cell")
              
//                //create and unwrap data in row: array[indexPath.row]
//                guard let item = self.array?[indexPath.row] else { return }
//
//                // delete row from Realm and from screen
//                try! self.realm.write {
//                    self.realm.delete(item)
//                }
                
                // update UI is mandatory (otherwise app crashes)
//                tableView.reloadData() - don't use if change behavior below
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

    
}
