//
//  TMDBViewCell.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 22/05/24.
//

import UIKit

class TMDBViewCell: UITableViewCell {
    
    @IBOutlet weak var labelOriginalTitle: UILabel!
    @IBOutlet weak var photo: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if photo != nil {
            photo!.image = nil
        }
    }
}
