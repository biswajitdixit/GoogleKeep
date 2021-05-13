import Foundation
import Firebase

class NoteRealtimeDatabase{
    
    static var instance:NoteRealtimeDatabase?
    var user: User!
    var notes = [NoteItem]()
    var deleteNote = [NoteItem]()
    var archiveNote = [NoteItem]()
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
  
    
    private init(){
        user = Auth.auth().currentUser
        ref = Database.database().reference()
    }
    
    static func getInstance() -> NoteRealtimeDatabase{
        if instance == nil {
            instance = NoteRealtimeDatabase()
            
        }
        return instance!
    }
   
    
    func createNote(title: String , description: String ){
        self.ref.child("users").child(self.user.uid).child("notes").childByAutoId().setValue(NoteDataModel.addTask(title: title , description: description))
    }
    
    
    func updateNote(title: String , description: String, key:String ){
        self.ref.child("users").child(self.user.uid).child("notes").child(key).updateChildValues(NoteDataModel.addTask(title: title , description: description))
        
    }
    
    func saveDeletedNote(title: String , description: String){
        self.ref.child("users").child(self.user.uid).child("deleteNote").childByAutoId().setValue(NoteDataModel.addTask(title: title , description: description))
    }
    
    func saveArchiveNote(title: String , description: String){
        self.ref.child("users").child(self.user.uid).child("archiveNote").childByAutoId().setValue(NoteDataModel.addTask(title: title , description: description))
    }
    
    func editArchiveNote(title: String , description: String, key:String){
        self.ref.child("users").child(self.user.uid).child("archiveNote").child(key).updateChildValues(NoteDataModel.addTask(title: title , description: description))
        
    }
}
