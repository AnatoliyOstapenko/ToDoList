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
    @objc dynamic var color: String = ""
    
    // define to-many relationships with ToDoModel class
    let itemToDoModel = List <ToDoModel>()

    
}


