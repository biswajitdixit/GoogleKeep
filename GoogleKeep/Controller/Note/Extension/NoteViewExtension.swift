

import Foundation
import UIKit

private let reuseIdentifier = "noteCell"
extension NotesViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filiteredNotes.count
        }else{
            return notes.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for: indexPath) as! NoteCell
        if isSearching{
            let note = filiteredNotes[indexPath.row]
            cell.titleLbl.text = note.title
            cell.descriptionLbl.text = note.description
            //cell.cardView.setCardView(View: cell.cardView)
            
        }else{
            let note = notes[indexPath.row]
            cell.titleLbl.text = note.title
            cell.descriptionLbl.text = note.description
           // cell.cardView.setCardView(View: cell.cardView)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let noteVC = self.storyboard?.instantiateViewController(withIdentifier: "noteVC") as? EditAndAddNote else {
            print("failed to navigate")
            return  }
        if isSearching {
            let note = filiteredNotes[indexPath.row]
            noteVC.noteToEdit = note
            noteVC.isEdit = true
            noteVC.key = note.ref?.key
           
            print(indexPath.row)
        }else{
            let note = notes[indexPath.row]
            noteVC.noteToEdit = note
            noteVC.isEdit = true
            noteVC.key = note.ref?.key
           
            print(indexPath.row)
        }
            
        navigationController?.pushViewController(noteVC, animated: true )
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: searchBar.bounds.height)
    }
   
}


extension UIView{
    func setCardView(View : UIView){
        
        View.layer.cornerRadius = 10.0
        View.layer.borderColor  =  UIColor.lightGray.cgColor
        View.layer.borderWidth = 2.0
        View.layer.shadowOpacity = 1.0
        View.layer.shadowColor =  UIColor.clear.cgColor
        View.layer.shadowRadius = 2.0
        View.layer.shadowOffset = CGSize(width:3, height: 3)
        View.layer.masksToBounds = true
        
    }
}

extension NotesViewController: UISearchBarDelegate {
    
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        collectionView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !isSearching {
            isSearching = true
            collectionView.reloadData()
        }
      searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filiteredNotes.removeAll()
        let searchPredicate = searchBar.text!
        filiteredNotes = notes.filter( {$0.title!.lowercased().range(of: searchPredicate.lowercased()) != nil})
        isSearching = (filiteredNotes.count == 0) ? false: true
        collectionView?.reloadData()
    }
    

}


