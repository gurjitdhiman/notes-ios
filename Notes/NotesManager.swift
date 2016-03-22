//
//  NotesManager.swift
//  Notes
//
//  Created by Gurjit Singh on 22/03/16.
//  Copyright © 2016 Example. All rights reserved.
//
import Alamofire

class NotesManager {
    // Get A Single note data.
    func getNote(id: Int, callback: (note: Note?, error: ErrorType?)->()){
        Alamofire.request(.PUT, "http://localhost:8080/notes/\(id)")
            .responseJSON { response in
                if let err = response.result.error {
                    callback(note: nil, error: err)
                }
                if let data = response.result.value as? Dictionary<String,AnyObject>,
                    let note = Note(n: data) {
                        callback(note: note, error: nil)
                } else {
                    callback(note: nil, error: InputError.InvalidData)
                }
        }
    }
    
    // Get All Notes data.
    func getNotes(callback: (data: [Note], error: ErrorType?)->()) {
        Alamofire.request(.GET, "http://localhost:8080/notes")
            .responseJSON { response in
                var notes:[Note] = []
                if let err = response.result.error {
                    // got an error in getting the data, need to handle it
                    print(response.result.error!)
                    
                    callback(data: notes, error: err)
                }
                
                if let values = response.result.value as? Array<AnyObject> {
                    // handle the results as JSON, without a bunch of nested if loops
                    //let jsonData = JSON(values)
                    for value in values {
                        if let notejson = value as? Dictionary<String,AnyObject>,
                            let note = Note(n: notejson) {
                                notes.append(note)
                        } else {
                            callback(data: notes, error: InputError.InvalidData)
                        }
                    }
                    callback(data: notes, error: nil)
                }
        }
    }
    
    // Add a new note to database
    func addNote(note: Note, callback: (data: Note?, error: ErrorType?)->()){
        var noteJson: Dictionary<String, AnyObject> = [
            "title" : note.title,
            "priority" : note.priority
        ]
        if note.content == "" {
            noteJson["content"] = ""
        } else {
            noteJson["content"] = note.content
        }
        Alamofire.request(.POST, "http://localhost:8080/notes", parameters: noteJson)
            .responseJSON { response in
                if let err = response.result.error {
                    callback(data: nil, error: err)
                }
                
                if let data = response.result.value as? Dictionary<String,AnyObject>,
                    let note = Note(n: data) {
                        callback(data: note, error: nil)
                } else {
                    callback(data: nil, error: InputError.InvalidData)
                }
        }
    }
    
    // Update Existing Note data
    func updateNote(note: Note, callback: (note: Note?, error: ErrorType?)->()){
        var noteJson: Dictionary<String, AnyObject> = [
            "title" : note.title,
            "priority" : note.priority
        ]
        if note.content == "" {
            noteJson["content"] = ""
        } else {
            noteJson["content"] = note.content
        }
        Alamofire.request(.PUT, "http://localhost:8080/notes/\(note.id!)", parameters: noteJson)
            .responseJSON { response in
                if let err = response.result.error {
                    callback(note: nil, error: err)
                }
                if let data = response.result.value as? Dictionary<String,AnyObject>,
                    let note = Note(n: data) {
                        callback(note: note, error: nil)
                } else {
                    callback(note: nil, error: InputError.InvalidData)
                }
        }
    }
    
    // Delete Existing Note
    func deteteNote(note: Note, callback: (error: ErrorType?)->()) {
        let url = "http://localhost:8080/notes/\(note.id!)"
        Alamofire.request(.DELETE, url)
            .response { request, response, data, error in
                if let err = error {
                    print(err)
                    callback(error: err)
                }
                callback(error: nil)
        }
    }
}
