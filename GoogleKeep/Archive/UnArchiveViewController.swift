import UIKit

class UnArchiveViewController: UIViewController {
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    var noteToUnArchive : NoteItem?
    var isUnArchive = false
    var key: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if isUnArchive == true{
            titleTxt.text = noteToUnArchive!.title
            descriptionTxt.text = noteToUnArchive!.description
        }
        
    }
    

    @IBAction func unArchive(_ sender: UIBarButtonItem) {
        if isUnArchive == true {
            NoteRealtimeDatabase.getInstance().createNote(title:titleTxt.text!, description: descriptionTxt.text!)
        noteToUnArchive?.ref?.removeValue()
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func editArchiveNote(_ sender: UIButton) {
        if isUnArchive == true {
            NoteRealtimeDatabase.getInstance().editArchiveNote(title: titleTxt.text!, description: descriptionTxt.text!, key: key!)
            self.navigationController?.popViewController(animated: true)
        }
            
    }
}
