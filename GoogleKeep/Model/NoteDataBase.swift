import Foundation
import FMDB

class NoteDataBase {
    
    func insertNote(title: String, descriptions: String) {
        let database = FMDatabase(url: noteURL)
       
        guard database.open() else {
            print("Unable to open database")
            return
        }
        do{
            try database.executeUpdate("INSERT INTO note(title,descriptions) values (?,?)", values: [title,descriptions])
        }
        catch{
            print("\(error.localizedDescription)")
        }
        database.close()
    }
   
    func getAllNotes() -> [NoteModel]{
        var notes = [NoteModel]()
        let myUrl = noteURL
        print(myUrl)
        let database = FMDatabase(url: noteURL)
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
                
            
            }
            catch{
                print("error:\(error.localizedDescription)")
            }
        }else{
            print("Unable to open my database")
            
        }
        database.close()
    return notes
  }
    
    func updateNote(title:String , description:String , id:String) {
        let database = FMDatabase(url: noteURL)
        guard database.open() else{
            print("not fetch database")
            return
        }
        do {
            try database.executeUpdate("UPDATE note SET title=?,descriptions=? WHERE id='\(id)'", values: [title, description])
        }catch let error{
            print (error.localizedDescription)
            
        }
        database.close()
     
       
    }
    
    func deleteNote(cellId: String ){
        let dataBase = FMDatabase(url: noteURL)
        guard dataBase.open() else{
            print("Note fetch")
            return
        }
        do{
            _ = try dataBase.executeUpdate("DELETE FROM note WHERE id =?", values:[cellId] )
        }catch let error {
            print(error.localizedDescription)
            
        }
        dataBase.close()
    }
    
}
