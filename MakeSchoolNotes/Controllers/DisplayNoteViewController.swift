//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {
  
  var note: Note?

  @IBOutlet weak var noteTitleTextField: UITextField!
  @IBOutlet weak var noteContentTextView: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // 1
    noteTitleTextField.text = note?.title ?? ""
    noteContentTextView.text = note?.content ?? ""
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let listNotesTableViewController = segue.destination as! ListNotesTableViewController
    
    if let identifier = segue.identifier {
      if identifier == "Cancel" {
        print("Cancel button tapped")
      } else if identifier == "Save" {
        print("Save button tapped")
        
        // define a local note which is equal the note coming from selected note.
        // if note exist update title and content
        if let note = self.note {
          // set the properties of note to the user entered text fields
          let newNote = Note()
          newNote.title = noteTitleTextField.text ?? ""
          newNote.content = noteContentTextView.text ?? ""
          RealmHelper.update(note, with: newNote)
        } else {
          // if note does not exist, create a new note
          let note = Note()
          note.title = noteTitleTextField.text ?? ""
          note.content = noteContentTextView.text ?? ""
          note.modificationTime = Date()
          
          RealmHelper.add(note)
        }
        listNotesTableViewController.notes = RealmHelper.retrieveNotes()
      }
    }
  }

}
