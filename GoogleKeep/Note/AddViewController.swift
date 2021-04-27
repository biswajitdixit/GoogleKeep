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
        NoteDataBase().updateNote(title: txtlable.text!, description: txtDescription.text!, id: id!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func insertChatToDB(title: String, descriptions: String){
        NoteDataBase().insertNote(title: title, descriptions: descriptions)
        self.navigationController?.popViewController(animated: true)
   }
    
}
