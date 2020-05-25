import Foundation

protocol CallBack_ApiManager {
    func dataReady(playlist: Playlist)
}

class ApiManager {
    
    var delegate: CallBack_ApiManager?
    
    init() {}
    
    func apiCall(link: String, delegate: CallBack_ApiManager) {
        self.delegate = delegate
        
        if let url = URL(string: link) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handler(data:urlResponse:error:))
            
            task.resume()
        }
    }
    
    func handler(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if (error != nil) {
            print("error = \(error)")
            return
        }
        
        
        if let safeData = data {
            // How to convert Data object to String
            let dataString = String(data: safeData, encoding: .utf8)
            print("dataString = \(dataString)")
            
            var playlist: Playlist! = jsonToPlaylist(data: safeData)
            print("playlist name = \(playlist.name)")
            print("playlist song count = \(playlist.songs.count)")
            
            sleep(2)
            delegate?.dataReady(playlist: playlist)
        }
    }
    
    func jsonToPlaylist(data: Data) -> Playlist? {
        let decoder = JSONDecoder()

        do {
            var playlist = try decoder.decode(Playlist.self, from: data)
            return playlist
        } catch {
            print("error = \(error)")
        }
        
        return nil
    }
}


/*
 let encoder = JSONEncoder()
 encoder.outputFormatting = .prettyPrinted
 let data = try! encoder.encode(playlist)
 let jsonString: String = String(data: data, encoding: .utf8)!
 print("jsonString=\(jsonString)")
 
 let defaults = UserDefaults.standard
 defaults.set(jsonString, forKey: "JSON")
 
 if let stringOne = defaults.string(forKey: "JSON") {
     print("stringOne=\(stringOne)")
     var playlist = try decoder.decode(Playlist.self, from: data)
     print("playlistName=\(playlist.name)")

 }
 */
