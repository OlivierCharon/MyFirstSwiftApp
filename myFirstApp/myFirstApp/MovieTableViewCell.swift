//
//  MovieTableViewCell.swift
//  myFirstApp
//
//  Created by Olivier on 22/10/2020.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var myMovieLabel: UILabel!
    @IBOutlet weak var myMoviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
