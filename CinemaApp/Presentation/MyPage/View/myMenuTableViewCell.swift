//
//  myMenuTableViewCell.swift
//  CinemaApp
//
//  Created by 유림 on 4/25/24.
//

import UIKit

class myMenuTableViewCell: UITableViewCell {
    
    var menuTitle: String?
    
    var item: ViewModelItem? {
        didSet {
            guard let item = item as? MyMenuItem else { return }
            menuTitle = item.menuTitle
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
