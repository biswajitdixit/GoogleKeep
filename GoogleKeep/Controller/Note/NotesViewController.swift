

import UIKit
import Firebase
import FirebaseAuth
import  FBSDKLoginKit

private let reuseIdentifier = "noteCell"
class NotesViewController: UIViewController {
    
    var isGridFlowLayoutUsed: Bool = false{
        didSet{
            updateButtonApperance()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching:Bool=false
    var filiteredNotes:[NoteItem] = []
    var notes = [NoteItem]()
    var user: User!
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
    var toggleButton = UIBarButtonItem()
    var gridFlowLayout = GridFlowLayout()
    var listFlowLayout = ListFlowLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showReminder), name: NSNotification.Name("showReminder"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDeleteNote), name: NSNotification.Name("showDelete"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSignIn), name: NSNotification.Name("showSignIn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showArchive), name: NSNotification.Name("showArchive"), object: nil)
        registerCell()
        collectionView.collectionViewLayout = gridFlowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        isGridFlowLayoutUsed = true
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        getAllNote()
        collectionView.reloadData()
        
        toggleButton =  UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
    }
    private func registerCell()
    {
        collectionView.register(UINib.init(nibName: "NoteCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    @objc func showReminder() {
        performSegue(withIdentifier: "showReminder", sender: nil)
    }
    
    @objc func showArchive(){
        performSegue(withIdentifier: "showArchive", sender: nil)
    }
    
    @objc func showDeleteNote(){
        performSegue(withIdentifier: "showDelete", sender: nil)
    }
    @objc func showSignIn() {
        FBSDKLoginKit.LoginManager().logOut()
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        print("signoutSuccessFully")
        
        let loginViewController = storyboard?.instantiateViewController(identifier: "LoginTableViewController") as? LoginTableViewController
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
       
        
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
    }
    
    @IBAction func onMoreTapped(){
        print("menu bar ")
        NotificationCenter.default.post(name: NSNotification.Name("showSideMenu"), object: nil)
    }

    
    
    fileprivate func updateButtonApperance(){
        let layout = isGridFlowLayoutUsed ? gridFlowLayout : listFlowLayout
        UIView.animate(withDuration: 0.2){ () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    
    
    @objc func butonTapped(sender: UIBarButtonItem) {
        if  isGridFlowLayoutUsed {
            toggleButton = UIBarButtonItem(image: #imageLiteral(resourceName: "gridicon"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
            isGridFlowLayoutUsed = false
        }else {
            toggleButton = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
            isGridFlowLayoutUsed = true
        }
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
        self.collectionView?.reloadData()
    }
    
    
   
    
    func getAllNote () {
        NoteRealtimeDatabase.getInstance().getAllNote { notes in
            self.notes = notes
            self.collectionView.reloadData()
        }
    }
   
    
   
        
    
    
}

