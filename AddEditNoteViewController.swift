//
//  AddEditNoteViewController.swift
//  Notes
//
//  Created by Gurjit Singh on 04/03/16.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit

class AddEditNoteViewController: UIViewController {
    
    // Create UI objects.
    let myTextField: UITextField = UITextField();
    let myTextArea: UITextView = UITextView()
    let myStepper: UIStepper = UIStepper()
    let priorityValueLabel: UILabel = UILabel()
    
    // Add madatory membors to hold called view object and note value.
    var deligate: AnyObject?
    var note: Note?

    // INITIAL LOAD FUNCTION.
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        self.addCustomView(self.note)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function to Dismiss current view when cancel button pressed.
    func cancelButtonPressed(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Add or Update note when save button pressed.
    func saveButtonPressed(){
        
        if myTextField.text == "" {
            let alertController = UIAlertController(title: "Warning!", message:
                "Title must required", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            // EDIT MODE.
            if (self.note != nil) {
                self.note?.title = myTextField.text!
                self.note?.content = myTextArea.text
                self.note?.priority = Int(myStepper.value)
                if let del = self.deligate as? ShowNoteViewController{
                    del.updateNote(self.note)
                }
            }
            else {
                // ADD MODE.
                let note = Note(id: nil, title: myTextField.text!, content: myTextArea.text, priority: Int(myStepper.value), created_at: NSDate())
                if let del = self.deligate as? NotesViewController{
                    del.saveNote(note)
                }
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func priorityChange(){
        priorityValueLabel.text = String(myStepper.value)
    }
    
    // Add Custom view to set UI objects positions and values if edit mode.
    func addCustomView(note: Note?) {
        
        // Add Nav bar Cancel button.
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("cancelButtonPressed"))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        // Add Nav Bar Save button.
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("saveButtonPressed"))
        self.navigationItem.rightBarButtonItem = saveButton
        
        // Set UI object values
        if let noteData = note {
            myTextField.text = noteData.title
            if let content = noteData.content {
                myTextArea.text = content
            }
            myStepper.value = Double(noteData.priority)
        }
        
        // Set posions to each UI object by NSLayoutConstraints.
        
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
        
        // Title text Field
        myTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        myTextField.layer.borderWidth = 1.0
        myTextField.layer.cornerRadius = 6
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
        
        // Content area text field
        myTextArea.layer.borderColor = UIColor.lightGrayColor().CGColor
        myTextArea.layer.cornerRadius = 6
        myTextArea.layer.borderWidth = 1
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
        
        // Priority Stepper
        myStepper.maximumValue = 5
        myStepper.minimumValue = 1
        myStepper.addTarget(self, action: Selector("priorityChange"), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(myStepper)
        
        myStepper.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(NSLayoutConstraint(
            item: myStepper,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -20
            )
        )
        
        self.view.addConstraint(NSLayoutConstraint(
            item: myStepper,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: myTextArea,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20
            )
        )
        
        // Priority Value;
        
        priorityValueLabel.text = String(myStepper.value)
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
        
    }
}
