//
//  Note.swift
//  Notes
//
//  Created by Gurjit Singh on 07/03/16.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum InputError: ErrorType {
    case InvalidData
}

// 7. Note struct
struct Note {
    var id: Int?
    var title: String
    var content: String?
    var priority: Int
    var createdAt: NSDate
    
    // 8. Costruct to create and initilize new note.
    init(id: Int?, title: String, content: String?, priority: Int, created_at: NSDate) {
        self.id = id
        self.title = title
        self.content = content
        self.priority = priority
        self.createdAt = created_at
    }
    init?(n: Dictionary<String,AnyObject>) {
        if let id = n["id"] as? Int , let title = n["title"] as? String , let priority = n["priority"] as? Int, let createdAt = n["created_at"] as? String {
            self.id = id
            self.title = title
            self.content =  n["content"] as? String
            self.priority = priority
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-ddEhh:mm:ss.SSSSSZ"
            if let date = dateFormatter.dateFromString(createdAt){
                self.createdAt = date
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func asJSON() -> Dictionary<String, AnyObject?> {
        return [
            "id": id,
            "title": title
        ]
    }
}



