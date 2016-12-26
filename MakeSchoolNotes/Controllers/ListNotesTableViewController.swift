//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
  
  // Model
  var notes: Results<Note>! {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    notes = RealmHelper.retrieveNotes()
  }
  
  // MARK: UITableViewDataSoource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
    
    // 1
    let row = indexPath.row
    
    // 2
    let note = notes[row]
    
    // 3
    cell.noteTitleLabel.text = note.title
    
    // 4
    cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
    
    // 5
    cell.contentOverviewLabel.text = note.content
    
    return cell
  }
  
  // Display delete option when user swipes right
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    // Check the delete mode for editingStyle
    if editingStyle == .delete {
      // delete the note form Realm
      RealmHelper.delete(notes[indexPath.row])
      // update notes array by reflecting changes
      notes = RealmHelper.retrieveNotes()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // 1: Store segue's identifier into a local variable called identifier
    if let identifier = segue.identifier {
      // check if displayNote segue is triggered
      if identifier == "displayNote" {
        // print a message to console
        print("Table view cell tapped")
        
        // find the indexpath of note that we want to open
        let indexPath = tableView.indexPathForSelectedRow!
        // define a local constant to store the row we selected.
        let note = notes[indexPath.row]
        // define a local constant to store an instance of DislayNoteViewController
        let displayNoteViewController = segue.destination as! DisplayNoteViewController
        // set note property of displayNoteViewController to our selected note
        displayNoteViewController.note = note
        
      } else if identifier == "addNote" {
        print("+ button tapped")
      }
      
    }
  }
  
  @IBAction func unwindToListNotesTableViewController(_ segue: UIStoryboardSegue) {
    
  }
  
}
