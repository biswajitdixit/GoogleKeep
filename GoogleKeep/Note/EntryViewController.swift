//
//  EntryViewController.swift
//  GoogleKeep
//
//  Created by admin on 09/04/21.
//

import UIKit
import  FMDB

protocol NoteDataDelegate {
    func getNoteData()
}
class EntryViewController: UIViewController ,NoteDataDelegate ,UISearchBarDelegate, UISearchControllerDelegate {
    func getNoteData() {
        getAllData()
    }
    @IBOutlet weak var tblView: UITableView!
    var notes = [NoteModel]()
    
    var searchController = UISearchController(searchResultsController: nil)
   
    private func searchBarSetUp(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.reloadData()
        getAllData()
        searchBarSetUp()
        dataModelSetUP()
        // Do any additional setup after loading the view.
    }
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        let storyboards = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboards.instantiateViewController(identifier: "AddViewController") as! AddViewController
        vc.noteDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func getAllData(){
        let myUrl = fileURL
        print(myUrl)
        notes.removeAll()
        let database = FMDatabase(url: fileURL)
        if database.open(){
            do{
                let rs = try database.executeQuery("SELECT * FROM note", values: nil)
                while rs.next(){
                    let items : NoteModel = NoteModel()
                    items.id = rs.string(forColumn: "id")
                    items.title = rs.string(forColumn: "title")
                    items.descriptions = rs.string(forColumn: "descriptions")
                    notes.append(items)
                }
                tblView.delegate = self
                tblView.dataSource = self
                tblView.reloadData()
            }
            catch{
                print("error:\(error.localizedDescription)")
            }
        }else{
            print("Unable to open my database")
            return
        }
        database.close()
    }
    

}
extension EntryViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //later
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
            
            let dataBase = FMDatabase(url: fileURL)
            guard dataBase.open() else{
                print("Note fetch")
                return
            }
            do{
                _ = try dataBase.executeUpdate("DELETE FROM note WHERE id =?", values:[cellId!] )
            }catch let error {
                print(error.localizedDescription)
                
            }
            dataBase.close()
            self.getNoteData()
            completionHandler(true)
        }
        let edit = UIContextualAction(style: .destructive, title: "Edit") { (action, scrollview, completionHandler) in
            let stroryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = stroryboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
            vc.titles = note.title
            vc.descriptions = note.descriptions
            vc.id = note.id
            vc.isEdit = true
            vc.noteDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
            completionHandler(true)
        }
        edit.backgroundColor = UIColor.blue
        let swipeConfigure = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeConfigure.performsFirstActionWithFullSwipe = false
        return swipeConfigure
    }
    
   

}
