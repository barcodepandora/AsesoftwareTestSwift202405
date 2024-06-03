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
    
    var task: Task<String, Error>?
    
    func configure(with urlString: String) {
        task?.cancel()
        task = Task {
            AsyncImageLoader.shared.loadImage(from: urlString) { [weak self] image in
                if self?.photo != nil {
                    self?.photo!.image = nil
                }
            }
            return "OK"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        if photo != nil {
            photo!.image = nil
        }
    }
}
