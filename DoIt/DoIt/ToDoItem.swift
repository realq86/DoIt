//
//  ToDoItem.swift
//  DoIt
//
//  Created by Michael on 7/2/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation

class TodoItem: NSObject {
    
    var text: String?
    var check: Bool = false
    
    init(text: String?, check: Bool?){
        
        self.text = text
        
        if let defaultCheck = check {
            self.check = defaultCheck
        }
        
    }
    
    
}
