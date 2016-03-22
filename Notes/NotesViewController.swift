//
//  NotesViewController.swift
//  Notes
//
//  Created by Gurjit Singh on 04/03/16.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit


// Inherit table view deligate and table view data shouce clasess to use its fuctions
class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // make an array of notes.
    var notes:[Note] = []
    var notesManager = NotesManager()

    @IBOutlet weak var tableView: UITableView!
    
    // INITIAL VIEW LOAD.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Table View data sourse and
        tableView.dataSource = self
        tableView.delegate = self
        
        // Reload Table view elements
        self.refresh()
        
        // Add Navigation bar buttons to add note and refresh list.
        let addBUtton = UIBarButtonItem(title: "Add Note", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("addNotePressed"))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refresh"))
        self.navigationItem.rightBarButtonItem = addBUtton
        self.navigationItem.leftBarButtonItem = refreshButton
        
        self.hidesBottomBarWhenPushed = true
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "notesCell")
    }
    
    
    // Table view library fuction to initilize no of table views.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Bundle of
        return 1
    }
    
     // Table view library fuction to initilize total no of cells.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of notes in array to set table view max lenth.
        return notes.count
    }
    
    
    // Customize Each cell view.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "notesCell")
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        
        if let content = note.content {
            if content.characters.count >= 8{
                cell.detailTextLabel?.text = content.substringToIndex(content.startIndex.advancedBy(8)).stringByAppendingString("...")
            } else {
                cell.detailTextLabel?.text = content
            }
        }
        
        return cell
    }
    
    // Add UITableViewDelegate fuction to make fuctionalaty when tap on table view cell.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let destination = ShowNoteViewController()
        destination.deligate = self
        destination.note = notes[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }

    // Function to shift controll to addEditNotesViewController to add a note when press on "Add note" button.
    func addNotePressed() {
        let addEditNoteViewController = AddEditNoteViewController(nibName: "AddEditNoteView", bundle: nil)
        addEditNoteViewController.deligate = self
        addEditNoteViewController.title = "Add Note"
        let navController = UINavigationController(rootViewController: addEditNoteViewController)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    
    // Re-Fetch notes lists and relosd table view.
    func refresh() {
        notesManager.getNotes { (data, error) -> () in
            if error == nil {
                self.notes = data
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            } else {
                print(error)
            }
        }
    }
    
    // Delete note by swipe left.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            notesManager.deteteNote(notes[indexPath.row], callback: { (error) -> () in
                if error == nil {
                    self.notes.removeAtIndex(indexPath.row)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                } else {
                    print(error)
                }
            })
        }
    }
    
    // Func to Update given note by find it in note array.
    func updateNote(note: Note) {
        
        notesManager.updateNote(note) { (note, error) -> () in
            if (error == nil){
                var i = 0;
                for noteObj in self.notes {
                    if(note!.id == noteObj.id){
                        self.notes[i] = note!
                        break
                    }
                    i++
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // Add New Node and reload table view.
    func saveNote(note: Note) {
        notesManager.addNote(note) { (data, error) -> () in
            if error == nil {
                self.notes.insert(data!, atIndex: 0)
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            } else {
                print(error)
            }
        }
    }
    

}
