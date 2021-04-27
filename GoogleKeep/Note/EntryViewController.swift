import UIKit
import  FMDB

class EntryViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var notes = [NoteModel]()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        getAllData()
        searchBarSetUp()
    
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will apper")
       getAllData()
    }
   
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        let storyboards = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboards.instantiateViewController(identifier: "AddViewController") as! AddViewController
      
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAllData(){
        notes = NoteDataBase().getAllNotes()
        tblView.reloadData()
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
            getAllData()
            
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
        let obj = notes[indexPath.row]
        cell.configureStudent(dict: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = self.notes[indexPath.row]
        let cellId = note.id
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, scrollview, completionHandler) in
            NoteDataBase().deleteNote(cellId: cellId!)
            self.getAllData()
            completionHandler(true)
        }
        let edit = UIContextualAction(style: .destructive, title: "Edit") { (action, scrollview, completionHandler) in
            let stroryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = stroryboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
            vc.titles = note.title
            vc.descriptions = note.descriptions
            vc.id = note.id
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
