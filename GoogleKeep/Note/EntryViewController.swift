//
//  EntryViewController.swift
//  GoogleKeep
//
//  Created by admin on 09/04/21.
//

import UIKit

class EntryViewController: UIViewController {
    
    var notes = [NoteModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        notes = ModelManager.getInstance().getAllNote()
        tblView.reloadData()
    }
    
    @IBOutlet weak var tblView: UITableView!
    
   

}
extension EntryViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.lblTitle.text = notes[indexPath.row].title
        cell.lblDescription.text = notes[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  120
    }
    
    
}
