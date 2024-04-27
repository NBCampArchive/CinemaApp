//
//  myMenuTableViewCell.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import UIKit

class myMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myMenuTitleLabel: UILabel!
    var myMenuTitle: String?
    
    var item: ViewModelItem? {
        didSet {
            guard let item = item as? MyMenuItem else { return }
            myMenuTitle = item.menuTitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("\(self.myMenuTitle) selected!!!")
    }
    
    
    func configure() {
        print("myMenuTitle: \(myMenuTitle)")
        myMenuTitleLabel.text = myMenuTitle
    }
}
