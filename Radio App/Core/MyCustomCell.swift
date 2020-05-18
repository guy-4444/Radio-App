import Foundation
import UIKit

protocol CallBack_clicks {
    func favoriteClicked(position: Int)
}
class MyCustomCell: UITableViewCell {
    @IBOutlet weak var cell_LBL_name: UILabel!
    @IBOutlet weak var cell_LBL_singer: UILabel!
    @IBOutlet weak var cell_BTN_favorite: UIButton!
    
    var delegate: CallBack_clicks?
    var position: Int?
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        delegate?.favoriteClicked(position: position ?? 0)
        print("hi!!")
    }
    
}
