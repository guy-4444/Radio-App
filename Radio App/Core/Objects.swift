import Foundation

class Playlist: Decodable {
        
    var name: String = ""
    var date: Int = 0
    var likes: Int = 0
    var onPlayed: Bool = false
    var songs: [Song] = []
    
    
    init() {}
}

class Song: Decodable {
    var name: String = ""
    var singer: String = ""
    var isFavorite: Bool? = false

    init() {}
}
