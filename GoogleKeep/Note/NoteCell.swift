import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
   
    func configureStudent(dict:NoteModel){
        lblTitle.text = dict.title
        lblDescription.text = dict.descriptions
    }

}
