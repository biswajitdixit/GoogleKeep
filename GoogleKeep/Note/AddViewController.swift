//
//  AddViewController.swift
//  GoogleKeep
//
//  Created by admin on 09/04/21.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var txtlable: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtDescription: UITextView!
    
    var noteData : NoteModel?
    var headerTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if headerTitle != ""{
            self.title = headerTitle
            txtlable.text = noteData?.title
            txtDescription.text = noteData?.description
        }
    }
    

    @IBAction func onClickAdd(_ sender: UIButton) {
        if headerTitle != ""{
            let note = NoteModel(id: noteData!.id, title: txtlable.text!, description: txtDescription.text!)
            let isUpDated = ModelManager.getInstance().updateNote(note: note)
            print("is updated :- \(isUpDated)")
        }else{
            let note = NoteModel(id: "", title: txtlable.text!, description: txtDescription.text!)
        
        let isSave = ModelManager.getInstance().saveNote(note: note)
        
        print("isSave :- \(isSave)")
    }
    

}
}
