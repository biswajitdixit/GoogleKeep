import UIKit
extension DeleteNoteViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filiteredNotes.count
        }else{
            return deleteNote.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"DeleteNoteCollectionViewCell", for: indexPath) as! DeleteNoteCollectionViewCell
        if isSearching{
            let note = filiteredNotes[indexPath.row]
            cell.titlLbl.text = note.title
            cell.descriptionLbl.text = note.description
            cell.cardView.setCardView(View: cell.cardView)
            
        }else{
            let note = deleteNote[indexPath.row]
            cell.titlLbl.text = note.title
            cell.descriptionLbl.text = note.description
            cell.cardView.setCardView(View: cell.cardView)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let restoreVC = self.storyboard?.instantiateViewController(withIdentifier: "RestoreViewController") as? RestoreViewController else {
            print("failed to navigate")
            return  }
        if isSearching {
            let note = filiteredNotes[indexPath.row]
           restoreVC.noteToRestore = note
           restoreVC.isRestoreOrDelete = true
           restoreVC.key = note.ref?.key
            print(indexPath.row)
        }else{
            let note = deleteNote[indexPath.row]
           restoreVC.noteToRestore = note
           restoreVC.isRestoreOrDelete = true
           restoreVC.key = note.ref?.key
           
            print(indexPath.row)
        }
            
        navigationController?.pushViewController(restoreVC, animated: true )
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: searchBar.bounds.height)
    }
    
}

extension DeleteNoteViewController: UISearchBarDelegate {
    
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
        filiteredNotes = deleteNote.filter( {$0.title!.lowercased().range(of: searchPredicate.lowercased()) != nil})
        isSearching = (filiteredNotes.count == 0) ? false: true
        collectionView?.reloadData()
    }
    

}
