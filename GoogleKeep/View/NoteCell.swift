import UIKit

class NoteCell:UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.layer.cornerRadius = 3
        titleLbl.layer.masksToBounds = true
        descriptionLbl.layer.cornerRadius = 3
        descriptionLbl.layer.masksToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = true
        cardView.layer.borderColor = UIColor.black.cgColor
        cardView.layer.borderWidth = 2.0
    }
}
