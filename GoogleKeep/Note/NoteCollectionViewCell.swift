
import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titlLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titlLbl.layer.cornerRadius = 3
        titlLbl.layer.masksToBounds = true
        descriptionLbl.layer.cornerRadius = 3
        descriptionLbl.layer.masksToBounds = true
        cardView.layer.cornerRadius = 3
        cardView.layer.masksToBounds = true
    }
    
    
}
