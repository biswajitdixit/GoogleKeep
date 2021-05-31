import Foundation
import FirebaseDatabase
import  UIKit

class NoteItem{
    var ref: DatabaseReference?
    var title: String?
    var description:String?
    
    init(snapshot: DataSnapshot){
        ref = snapshot.ref
        
        let data = snapshot.value as! Dictionary<String , String>
        title = data["title"]! as String
        description = data["description"]! as String
    }
}
