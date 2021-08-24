//
//  ToDoModel.swift
//  ToDoList
//
//  Created by MacBook on 23.08.2021.
//

import Foundation

// add Encodable protocol to use encoding item array
class ToDoModel: Encodable {
    
    var title: String = ""
    var done: Bool = false
    
    
}
