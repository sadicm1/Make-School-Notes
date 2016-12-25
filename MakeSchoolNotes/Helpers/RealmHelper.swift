//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by Mehmet Sadıç on 25/12/2016.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
  // static methods will go to here
  
  static func addNote(note: Note) {
    // save a note to default Realm
    let realm = try! Realm()
    try! realm.write() {
      realm.add(note)
    }
  }
  
  static func deleteNote(note: Note) {
    // delete a note from default Realm
    let realm = try! Realm()
    try! realm.write() {
      realm.delete(note)
    }
  }
  
  static func updateNote(noteToBeUpdated: Note, newNote: Note) {
    // update an existing note which is in default Realm with a new note
    let realm = try! Realm()
    try! realm.write() {
      noteToBeUpdated.title = newNote.title
      noteToBeUpdated.content = newNote.content
      noteToBeUpdated.modificationTime = newNote.modificationTime
    }
  }
  
  static func retrieveNotes() -> Results<Note> {
    // retrive all notes from default Realm
    let realm = try! Realm()
    return realm.objects(Note).sorted("modificationTime", ascending: false)
  }
  
}
