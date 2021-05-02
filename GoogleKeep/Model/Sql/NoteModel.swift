import Foundation

class  NoteModel : Codable  {
    var id:String?
    var title: String?
    var descriptions:String?
    init(title: String, descriptions:String) {
        self.title = title
        self.descriptions = descriptions
       // self.id = id
    }
    init() {
        
    }
}
