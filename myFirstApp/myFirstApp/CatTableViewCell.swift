//
//  CatTableViewCell.swift
//  myFirstApp
//
//  Created by Olivier on 21/10/2020.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    @IBOutlet weak var myCatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
