//
//  ToDoModel.swift
//  ToDoList
//
//  Created by MacBook on 23.08.2021.
//

import Foundation

// add Codable (Encodable, Decodable included) protocol to use save and load locally item array
class ToDoModel: Codable {
    
    var title: String = ""
    var done: Bool = false
    
    
}
