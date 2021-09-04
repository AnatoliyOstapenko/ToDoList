//
//  ToDoModel.swift
//  ToDoList
//
//  Created by MacBook on 02.09.2021.
//

import Foundation
import RealmSwift

// create superclass RealmSwiftObject
class ToDoModel: Object {
    
    @objc dynamic var  title: String = ""
    @objc dynamic var  done: Bool = false
    
    // create parent category that has relations with Category class
    let parentCategory = LinkingObjects(fromType: Category.self, property: "itemToDoModel")
}
