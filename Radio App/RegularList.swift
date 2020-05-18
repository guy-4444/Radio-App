/*
 import UIKit

 class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
     
     @IBOutlet weak var main_LST_songs: UITableView!
     
     var animals = ["Cat", "Lion", "Dog", "Eagle", "Bull", "Bird"]
     let cellReuseIdentifier = "cell"
     
     
     var myApiManager: ApiManager!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         
         self.main_LST_songs.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

         main_LST_songs.delegate = self
         main_LST_songs.dataSource = self
     }
     
     
     
     // number of rows in table view
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.animals.count
     }

     
     // create a cell for each table view row
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell : UITableViewCell? = self.main_LST_songs.dequeueReusableCell(withIdentifier: cellReuseIdentifier)

         cell?.textLabel?.text = self.animals[indexPath.row]

         if (cell == nil) {
             cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
         }
         
         return cell!
     }
 }

 */
