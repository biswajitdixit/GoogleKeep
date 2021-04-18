//
//  Util.swift
//  GoogleKeep
//
//  Created by admin on 18/04/21.
//

import Foundation
import  UIKit

class Util{
    
    static let share = Util()
    
    //MArk:- Getting Path of our database
    
    func getPath(dbName: String) -> String{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent(dbName)
        print(fileUrl.path)
        return fileUrl.path
        
    }
    
    //Mark:- If Databasepath is not exist the creating database path
    func copyDatabase(dbName: String) {
        let dbPath = getPath(dbName: "GoogleKeep.db")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath){
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(dbName)
            do{
                try fileManager.copyItem(atPath: file!.path, toPath: dbPath)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
       
    }
}
