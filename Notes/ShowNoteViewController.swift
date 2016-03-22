//
//  ShowNoteViewController.swift
//  Notes
//
//  Created by Gurjit Singh on 07/03/16.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit

class ShowNoteViewController: UIViewController {

    
    // Add show note UI objects
    let myTextField: UILabel = UILabel()
    let myTextArea: UITextView = UITextView()
    let priorityValueLabel: UILabel = UILabel()
    let createdAtLabel: UILabel = UILabel()
    
    // Add Recommended note and Mandatory deligate class member
    // Initilized when Tap on note event call
    var note: Note!
    var deligate: NotesViewController?
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        // Add custom view objects to view
        self.addCustomView(self.note)
        
        // Set UI Objects values
        self.setUIObjectsValues(note)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function to call shift controll to Add Edit Note Controller as Edit mode
    func editButtonPressed(){
        
        let addEditNoteViewController = AddEditNoteViewController(nibName: "AddEditNoteView", bundle: nil)
        addEditNoteViewController.deligate = self
        addEditNoteViewController.note = self.note
        addEditNoteViewController.title = "Edit Note"
        let navController = UINavigationController(rootViewController: addEditNoteViewController)
        self.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    // Func to pass controll to update note notes view func.
    func updateNote(note: Note!){
        self.note = note
        self.deligate?.updateNote(note)
        
        // Set note values
        self.setUIObjectsValues(note)
        
    }
    
    // Set UI objects values
    func setUIObjectsValues(note: Note) {
        // Set UI Objects values
        myTextField.text = note.title
        
        if let content = note.content {
            myTextArea.text = content
        }
        
        priorityValueLabel.text = String(note.priority)
        
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let DateInFormat:String = dateFormatter.stringFromDate(note.createdAt)
        createdAtLabel.text = String(DateInFormat)
    }
    
    
    // Add Custom view to set note UI objects positions and values.
    func addCustomView(note: Note) {
        
        // Add Nav Bar Edit button
        let saveButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("editButtonPressed"))
        self.navigationItem.rightBarButtonItem = saveButton
        
        
        // Title label
        let titleLabel: UILabel = UILabel()
        titleLabel.font = UIFont.boldSystemFontOfSize(15.0)
        titleLabel.text = "Title:"
        
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabelConstraint = NSLayoutConstraint(
            item: titleLabel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.LessThanOrEqual,
            toItem: self.view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 20
        )
        
        titleLabelConstraint.priority = 1000
        
        self.view.addConstraint(
            titleLabelConstraint
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: titleLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 40
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: titleLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: UIApplication.sharedApplication().statusBarFrame.size.height + self.navigationController!.navigationBar.frame.size.height + 10
            )
        )
        
        // Title text Area
        
        self.view.addSubview(myTextField)
        
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(
            item: myTextField,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: titleLabel,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 5
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: myTextField,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -20
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: myTextField,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: UIApplication.sharedApplication().statusBarFrame.size.height + self.navigationController!.navigationBar.frame.size.height + 10
            )
        )
        
        
        ///////////////////////////////
        // Content label
        let contentLabel: UILabel = UILabel()
        contentLabel.font = UIFont.boldSystemFontOfSize(15.0)
        contentLabel.text = "Content:"
        
        self.view.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(NSLayoutConstraint(
            item: contentLabel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 20
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: contentLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 80
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: contentLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: myTextField,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20
            )
        )
        
        // Content area
        self.view.addSubview(myTextArea)
        
        myTextArea.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(
            item: myTextArea,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 20
            )
        )
        self.view.addConstraint(NSLayoutConstraint(
            item: myTextArea,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: myTextField,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 50
            )
        )
        self.view.addConstraint(NSLayoutConstraint(
            item: myTextArea,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -20
            )
        )
        self.view.addConstraint(NSLayoutConstraint(
            item: myTextArea,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: -80
            )
        )
        
        // Priority label
        let priorityLabel: UILabel = UILabel()
        priorityLabel.font = UIFont.boldSystemFontOfSize(15.0)
        priorityLabel.text = "Priority:"
        
        self.view.addSubview(priorityLabel)
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(NSLayoutConstraint(
            item: priorityLabel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 20
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: priorityLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 80
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: priorityLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: myTextArea,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20
            )
        )
        
        //Priority Value
        
        //priorityValueLabel.textAlignment = NSTextAlignment.Right
        
        self.view.addSubview(priorityValueLabel)
        priorityValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.view.addConstraint(NSLayoutConstraint(
            item: priorityValueLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 10
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: priorityValueLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: myTextArea,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: priorityValueLabel,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0
            )
        )
        
        ////////////////////////////////////////////
        
        // Date label
        let dateLabel: UILabel = UILabel()
        dateLabel.font = UIFont.boldSystemFontOfSize(15.0)
        dateLabel.text = "Created At:"
        
        self.view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(NSLayoutConstraint(
            item: dateLabel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 20
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: dateLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 120
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: dateLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: priorityLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 10
            )
        )
        
        // Date text Area
        self.view.addSubview(createdAtLabel)
        
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(
            item: createdAtLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 110
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: createdAtLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: priorityLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 10
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: createdAtLabel,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -20
            )
        )
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
