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
  
  static func add(_ note: Note) {
    // save a note to default Realm
    let realm = try! Realm()
    try! realm.write() {
      realm.add(note)
    }
  }
  
  static func delete(_ note: Note) {
    // delete a note from default Realm
    let realm = try! Realm()
    try! realm.write() {
      realm.delete(note)
    }
  }
  
  static func update(_ note: Note, with newNote: Note) {
    // update an existing note which is in default Realm with a new note
    let realm = try! Realm()
    try! realm.write() {
      note.title = newNote.title
      note.content = newNote.content
      note.modificationTime = newNote.modificationTime
    }
  }
  
  static func retrieveNotes() -> Results<Note> {
    // retrive all notes from default Realm
    let realm = try! Realm()
    return realm.objects(Note.self).sorted(byProperty: "modificationTime", ascending: false)
  }
  
}
