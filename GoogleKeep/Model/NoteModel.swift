//
//  NoteModel.swift
//  GoogleKeep
//
//  Created by admin on 18/04/21.
//

import Foundation

let fileURL = try! FileManager.default
    .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    .appendingPathComponent("Note.db")
class  NoteModel : NSObject  {
    var id:String?
    var title: String?
    var descriptions:String?
}
