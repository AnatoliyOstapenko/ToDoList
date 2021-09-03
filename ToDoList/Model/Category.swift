//
//  Category.swift
//  ToDoList
//
//  Created by MacBook on 02.09.2021.
//

import Foundation
import RealmSwift

// create superclass RealmSwiftObject
class Category: Object {
    @objc dynamic var name: String = ""
    
    // define to-many relationships (one and more relationships)
    let itemToDoModel = List <ToDoModel>()

    
}


