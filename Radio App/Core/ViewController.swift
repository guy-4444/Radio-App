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


