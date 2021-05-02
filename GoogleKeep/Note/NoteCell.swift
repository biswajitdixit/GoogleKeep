import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
   
    func configureNote(dict:NoteModel){
        lblTitle.text = dict.title
        lblDescription.text = dict.descriptions
        
    }

}
