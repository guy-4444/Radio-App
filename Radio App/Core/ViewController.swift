import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let INTERNER_CONNECTION_ON = false
    
    @IBOutlet weak var main_LST_songs: UITableView!
    
    let API_WEST = "https://pastebin.com/raw/9SiLh7Ej"
    let API_EAST = "https://pastebin.com/raw/yXEV0rJJ"
    
    // Api from server task
    // Read JSON
    // Put in list
    // Get location
    // Download playlist by location
    // Save last playlist in local memory
    
    let cellReuseIdentifier = "song_cell"
    var playlist: Playlist?
    
    var myApiManager: ApiManager!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (INTERNER_CONNECTION_ON) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        } else {
            getOldDataFromLocalStorage()
        }
    }
    
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//    let data = try! encoder.encode(playlist)
//    let jsonString: String = String(data: data, encoding: .utf8)!
//    print("jsonString=\(jsonString)")
//
//    let defaults = UserDefaults.standard
//    defaults.set(jsonString, forKey: "JSON")
//
//    if let stringOne = defaults.string(forKey: "JSON") {
//        print("stringOne=\(stringOne)")
//        var playlist = try decoder.decode(Playlist.self, from: data)
//        print("playlistName=\(playlist.name)")
//
//    }
    
    //     String(json)   ->   Data   ->      Object(Playlist)
    func getOldDataFromLocalStorage() {
        var playlistJson = UserDefaults.standard.string(forKey: "LAST_PLAYLIST")
        print("playlistJson: \(playlistJson)")

        if let safePlaylistJson = playlistJson {
            let decoder = JSONDecoder()
            let data = Data(safePlaylistJson.utf8)
            do {
                self.playlist = try decoder.decode(Playlist.self, from: data)
                print("playlistName=\(self.playlist?.name)")
                setupList()
            } catch {}
        }
    }
    
    //     Object(Playlist)   ->   Data   ->   String(json)
    func savePlaylistInLocalStorage(playlist: Playlist) {
        print("saved Playlist In Local Storage")

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(playlist)
        let playlistJson: String = String(data: data, encoding: .utf8)!

        UserDefaults.standard.set(playlistJson, forKey: "LAST_PLAYLIST")
    }
    
    func downloadPlaylistByLocation(area: String) {
        if area == "EAST" {
            myApiManager = ApiManager()
            myApiManager.apiCall(link: API_EAST, delegate: self)
            myApiManager.delegate = self
        } else if area == "WEST" {
            myApiManager = ApiManager()
            myApiManager.apiCall(link: API_WEST, delegate: self)
            myApiManager.delegate = self
        }
    }
    
    func setupList() {
        playlist?.songs[0].isFavorite = true
        playlist?.songs[2].isFavorite = true
        main_LST_songs.delegate = self
        main_LST_songs.dataSource = self
        main_LST_songs.reloadData()
    }
}

// MARK: CallBack_clicks
extension ViewController: CallBack_clicks {
    
    func favoriteClicked(position: Int) {
        let fav: Bool! = playlist?.songs[position].isFavorite ?? false
        playlist?.songs[position].isFavorite = !fav
        main_LST_songs.reloadData()
    }
}

// MARK: ApiManager CallBack
extension ViewController: CallBack_ApiManager {
    
    func dataReady(playlist: Playlist) {
        self.playlist = playlist
        savePlaylistInLocalStorage(playlist: playlist)
        
        DispatchQueue.main.async {
            self.setupList()
        }
    }
}

// MARK: UITableView Delegates
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped song number \(playlist!.songs[indexPath.row].name) - \(playlist!.songs[indexPath.row].singer)")
    }
}

extension ViewController: UITableViewDataSource {
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlist?.songs.count ?? 0
    }
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MyCustomCell? = self.main_LST_songs.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyCustomCell
        
        cell?.delegate = self
        cell?.position = indexPath.row
        
        cell?.cell_LBL_name?.text = self.playlist?.songs[indexPath.row].name
        cell?.cell_LBL_singer?.text = self.playlist?.songs[indexPath.row].singer
        
        if (self.playlist?.songs[indexPath.row].isFavorite ?? false) {
            if let image = UIImage(named: "ic_full_heart.png") {
                cell?.cell_BTN_favorite.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "ic_empty_heart2.png") {
                cell?.cell_BTN_favorite.setImage(image, for: .normal)
            }
        }
        
        if (cell == nil) {
            cell = MyCustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        return cell!
    }
}

// MARK: Location Delegates
extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Locations ready.")
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            print("Location: \(lat) \(lon)")
            
            if lon > 34.845478 {
                downloadPlaylistByLocation(area: "EAST")
            } else {
                downloadPlaylistByLocation(area: "WEST")
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}


/*
 import UIKit
 
 class ViewController: UIViewController {
 
 
 @IBOutlet weak var main_LST_songs: UITableView!
 
 let API = "https://pastebin.com/raw/LMhvH1ZR"
 
 // Api from server task
 // Read JSON
 // Put in list
 
 let cellReuseIdentifier = "song_cell"
 var playlist: Playlist?
 
 var myApiManager: ApiManager!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 myApiManager = ApiManager()
 myApiManager.apiCall(link: API, delegate: self)
 myApiManager.delegate = self
 }
 
 func setupList() {
 playlist?.songs[0].isFavorite = true
 playlist?.songs[2].isFavorite = true
 main_LST_songs.delegate = self
 main_LST_songs.dataSource = self
 main_LST_songs.reloadData()
 }
 }
 
 // MARK: CallBack_clicks
 extension ViewController: CallBack_clicks {
 
 func favoriteClicked(position: Int) {
 let fav: Bool! = playlist?.songs[position].isFavorite ?? false
 playlist?.songs[position].isFavorite = !fav
 main_LST_songs.reloadData()
 }
 }
 
 // MARK: ApiManager CallBack
 extension ViewController: CallBack_ApiManager {
 
 func dataReady(playlist: Playlist) {
 self.playlist = playlist
 
 DispatchQueue.main.async {
 self.setupList()
 }
 }
 }
 
 // MARK: UITableView Delegates
 extension ViewController: UITableViewDelegate {
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 print("You tapped song number \(playlist!.songs[indexPath.row].name) - \(playlist!.songs[indexPath.row].singer)")
 }
 }
 
 extension ViewController: UITableViewDataSource {
 // number of rows in table view
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return self.playlist?.songs.count ?? 0
 }
 
 
 // create a cell for each table view row
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 var cell : MyCustomCell? = self.main_LST_songs.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MyCustomCell
 
 cell?.delegate = self
 cell?.position = indexPath.row
 
 cell?.cell_LBL_name?.text = self.playlist?.songs[indexPath.row].name
 cell?.cell_LBL_singer?.text = self.playlist?.songs[indexPath.row].singer
 
 if (self.playlist?.songs[indexPath.row].isFavorite ?? false) {
 if let image = UIImage(named: "ic_full_heart.png") {
 cell?.cell_BTN_favorite.setImage(image, for: .normal)
 }
 } else {
 if let image = UIImage(named: "ic_empty_heart2.png") {
 cell?.cell_BTN_favorite.setImage(image, for: .normal)
 }
 }
 
 if (cell == nil) {
 cell = MyCustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
 }
 
 return cell!
 }
 }
 
 
 
 */


/*
 
 struct defaultsKeys {
 static let keyOne = "firstStringKey"
 static let keyTwo = "secondStringKey"
 }
 
 let defaults = UserDefaults.standard
 defaults.set("Some String Value", forKey: defaultsKeys.keyOne)
 defaults.set("Another String Value", forKey: defaultsKeys.keyTwo)
 
 // Getting
 
 let defaults = UserDefaults.standard
 if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
 print(stringOne) // Some String Value
 }
 if let stringTwo = defaults.string(forKey: defaultsKeys.keyTwo) {
 print(stringTwo) // Another String Value
 }
 */
