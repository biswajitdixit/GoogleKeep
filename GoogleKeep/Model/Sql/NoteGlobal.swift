import Foundation

let noteURL = try! FileManager.default
    .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    .appendingPathComponent("Note.db")
