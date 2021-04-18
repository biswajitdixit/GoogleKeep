//
//  EntryViewController.swift
//  GoogleKeep
//
//  Created by admin on 09/04/21.
//

import UIKit

class EntryViewController: UIViewController,UISearchBarDelegate, UISearchControllerDelegate  {
    @IBOutlet weak var tblView: UITableView!
    var notes = [NoteModel]()
    var searchController = UISearchController(searchResultsController: nil)
    
    private func DataModelSetUP(){
        var note = notes
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       notes = ModelManager.getInstance().getAllNote()
        tblView.reloadData()
        searchBarSetUp()
        DataModelSetUP()
    }
    
   
    private func searchBarSetUp(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
   

}
extension EntryViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        //later
        guard let searchText = searchController.searchBar.text else{return}
        if searchText == "" {
            DataModelSetUP()
            
        }else{
            DataModelSetUP()
           notes = notes.filter{
            $0.title.lowercased().contains(searchText.lowercased())
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
        cell.lblTitle.text = notes[indexPath.row].title
        cell.lblDescription.text = notes[indexPath.row].description
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(onClickEdit(_:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(onClickDelete(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  120
    }
    
    @objc func onClickEdit(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "AddViewController") as!
        AddViewController
        vc.noteData = notes[sender.tag]
        vc.headerTitle = "Update"
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func onClickDelete(_ sender: UIButton){
        let isDeleted = ModelManager.getInstance().deleteNote(note: notes[sender.tag])
        notes.remove(at: sender.tag)
        tblView.reloadData()
        print("is Deleted :- \(isDeleted)")
    }

}
