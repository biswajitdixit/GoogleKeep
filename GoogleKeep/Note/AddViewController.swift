import UIKit
import Firebase

class AddViewController: UIViewController {

    
  //  var user: User!
   // var notes = [NoteItem]()
   // var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
    
    @IBOutlet weak var txtlable: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtDescription: UITextView!
    
    var isEdit = false
    var titles : String?
    var descriptions:String?
    var id: String?
    var key: String?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if isEdit == true{
            txtlable.text = titles
            txtDescription.text = descriptions
        }
    }
    
    @IBAction func onClickAdd(_ sender: UIButton) {
        if isEdit == true {

            NoteRealtimeDatabase.getInstance().updateNote(title: txtlable.text!, description: txtDescription.text!, key: key!)
            self.navigationController?.popViewController(animated: true)
        }
        else if !(txtlable.text!.isEmpty) && !(txtDescription.text!.isEmpty){
            NoteRealtimeDatabase.getInstance().createNote(title: txtlable.text!, description: txtDescription.text!)
            self.navigationController?.popViewController(animated: true)
        }
    
    }
}

