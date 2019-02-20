//
//  Item.swift
//  ToDoey
//
//  Created by admin on 2/14/19.
//  Copyright © 2019 Eras Noel. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    
    var title : String = ""
    
    var done : Bool = false
    
}

