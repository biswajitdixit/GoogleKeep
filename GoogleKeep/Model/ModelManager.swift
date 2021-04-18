//
//  ModelManager.swift
//  GoogleKeep
//
//  Created by admin on 18/04/21.
//

import Foundation
import UIKit

var shareInstance = ModelManager()

class ModelManager{
    var database : FMDatabase? = nil
    static func getInstance() -> ModelManager{
        if shareInstance.database == nil{
            shareInstance.database = FMDatabase(path: Util.share.getPath(dbName: "GoogleKeep.db"))
        }
        return shareInstance
    }
    
    //Mark:- Saving Note Data
    func saveNote(note: NoteModel) -> Bool{
        shareInstance.database?.open()
        
        let isSave = shareInstance.database?.executeUpdate("INSERT INTO note (title , description) VALUES(?,?)", withArgumentsIn: [note.title, note.description])
        shareInstance.database?.close()
        return isSave!
    }
}
