import Foundation

/*
class ServerManager {
    
    func apiCall(fullUrl: String) {
        if let url: URL = URL(string: fullUrl) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handler(data: urlResponse: error:))
            
            task.resume()
        }
    }
    
    func handler(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if error != nil {
            print("error:\(error)")
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print("dataString:\(dataString!)")
            self.parseJSON(data: safeData)
        }
        
    }
    
    func jsonToPlaylist(data: Data) {
        let decoder = JSONDecoder()
        
        do {
            var model = try decoder.decode(Playlist.self, from: data)
            print("name: \(model.name)")
            print("first song: \(model.songs[0])")
            print("first song singer: \(model.songs[0].singer)")
        } catch {
            print("Error: \(error)")
        }

    }
}
*/
