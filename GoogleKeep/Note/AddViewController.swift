//
//  AddViewController.swift
//  GoogleKeep
//
//  Created by admin on 09/04/21.
//

import UIKit
import FMDB

class AddViewController: UIViewController {

    @IBOutlet weak var txtlable: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtDescription: UITextView!
    var isEdit = false
    var titles : String?
    var descriptions:String?
    var id: String?
    
    var noteData : NoteModel?
    var noteDelegate : NoteDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEdit == true{
            txtlable.text = titles
            txtDescription.text = descriptions
        }
       
    }
    

    @IBAction func onClickAdd(_ sender: UIButton) {
        if isEdit == true {
            updateNote()
        }
        else if !(txtlable.text!.isEmpty) && !(txtDescription.text!.isEmpty){
            insertChatToDB(title: txtlable.text!, descriptions: txtDescription.text!)
        }
    

}
    
    func updateNote(){
        let database = FMDatabase(url: fileURL)
        guard database.open() else{
            print("not fetch database")
            return
        }
        do {
            try database.executeUpdate("UPDATE note SET title=?,descriptions=? WHERE id='\(id!)'", values: [txtlable.text!,txtDescription.text!])
        }catch let error{
            print (error.localizedDescription)
            
        }
        database.close()
        noteDelegate?.getNoteData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func insertChatToDB(title: String, descriptions: String){
        let database = FMDatabase(url: fileURL)
       
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do{
            try database.executeUpdate("INSERT INTO note(title,descriptions) values (?,?)", values: [title,descriptions])
        }
        catch{
            print("\(error.localizedDescription)")
        }
        database.close()
        noteDelegate?.getNoteData()
        self.navigationController?.popViewController(animated: true)
    }
}
