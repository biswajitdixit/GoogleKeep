import UIKit
import  Firebase

class EntryViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var user: User!
    var notes = [NoteItem]()
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
    
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        startObservingDatabase()
         searchBarSetUp()
        tblView.reloadData()
     
    
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will apper")
     
    }
   
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        let storyboards = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboards.instantiateViewController(identifier: "AddViewController") as! AddViewController
      
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    func startObservingDatabase (){
        databasehandle = ref.child("users/\(self.user.uid)/notes").observe(.value, with: { (snapshot) in
            var newNote = [NoteItem]()
            
            for itemSnapShot in snapshot.children {
                let note = NoteItem(snapshot: itemSnapShot as! DataSnapshot)
                newNote.append(note)
            }
            self.notes = newNote
            self.tblView.reloadData()
        })
    }
    deinit {
        ref.child("users/\(self.user.uid)/notes").removeObserver(withHandle: databasehandle)
    }
    
}

extension EntryViewController:UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating{
    
    private func searchBarSetUp(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else{return}
        if searchText == "" {
            startObservingDatabase()
        }else{
           
           notes = notes.filter{
            $0.title!.lowercased().contains(searchText.lowercased())
            }
       }
        tblView.reloadData()
   }
}

extension EntryViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.lblDescription.text = note.description
        cell.lblTitle.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  80
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = self.notes[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, scrollview, completionHandler) in
            note.ref?.removeValue()
            completionHandler(true)
        }
        let edit = UIContextualAction(style: .destructive, title: "Edit") { (action, scrollview, completionHandler) in
            let stroryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = stroryboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
            
            vc.titles = note.title
            vc.descriptions = note.description
            vc.key = note.ref?.key
            vc.isEdit = true
            self.navigationController?.pushViewController(vc, animated: true)
            
            completionHandler(true)
        }
        edit.backgroundColor = UIColor.blue
        let swipeConfigure = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeConfigure.performsFirstActionWithFullSwipe = false
        return swipeConfigure
    }
    
   

}
