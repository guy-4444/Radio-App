import Foundation


class Playlist: Codable {
        
    var name: String = ""
    var date: Int = 0
    var likes: Int = 0
    var onPlayed: Bool = false
    var songs: [Song] = []
    
    
    init() {}
}

class Song: Codable {
    var name: String = ""
    var singer: String = ""
    var isFavorite: Bool? = false

    init() {}
}

