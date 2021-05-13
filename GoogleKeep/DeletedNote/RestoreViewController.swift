
import UIKit

class RestoreViewController: UIViewController {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    var noteToRestore : NoteItem?
    var isRestoreOrDelete = false
    var key: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if isRestoreOrDelete == true{
            titleTxt.text = noteToRestore!.title
            descriptionTxt.text = noteToRestore!.description
        }
    }
    
    @IBAction func restoreNote(_ sender: UIButton) {
        if isRestoreOrDelete == true {
            NoteRealtimeDatabase.getInstance().createNote(title:noteToRestore!.title!, description: noteToRestore!.description!)
        noteToRestore?.ref?.removeValue()
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func permanentDelete(_ sender: UIButton) {
        noteToRestore?.ref?.removeValue()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
