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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickAdd(_ sender: UIButton) {
        let note = NoteModel(title: txtlable.text!, description: txtDescription.text!)
        
        let isSave = ModelManager.getInstance().saveNote(note: note)
        
        print("isSave :- \(isSave)")
    }
    

}
