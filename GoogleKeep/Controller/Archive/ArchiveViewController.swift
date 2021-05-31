
import UIKit
import Firebase
import FirebaseAuth
private let reuseIdentifier = "noteCell"
class ArchiveViewController: UIViewController {
    var isGridFlowLayoutUsed: Bool = false{
        didSet{
            updateButtonApperance()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching:Bool=false
    var filiteredNotes:[NoteItem] = []
    var archiveNote = [NoteItem]()
    var user: User!
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
    var toggleButton = UIBarButtonItem()
    var gridFlowLayout = GridFlowLayout()
    var listFlowLayout = ListFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        collectionView.collectionViewLayout = gridFlowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        isGridFlowLayoutUsed = true
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        getAllArchiveNote()
        collectionView.reloadData()
        
        toggleButton =  UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
       
  
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
   
   @IBAction func backToNote(_ sender: Any) {
       dismiss(animated: true, completion: nil)
   }
    private func registerCell()
    {
        collectionView.register(UINib.init(nibName: "NoteCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
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
   
    
   
   func getAllArchiveNote () {
    NoteRealtimeDatabase.getInstance().getAllArchiveNote { archiveNote in
        self.archiveNote = archiveNote
        self.collectionView.reloadData()
        }
           
    }
   

}
