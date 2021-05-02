class NoteDataModel
{
    static func addTask(title:String,description: String) -> [String:String]
        {
        let dict = ["title":title,"description":description]
            return dict
        }
}
