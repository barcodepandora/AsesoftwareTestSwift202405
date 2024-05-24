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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if photo != nil {
            photo!.image = nil
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = CGSize(width: targetSize.width, height: 124)
        return size
    }
    
    func configure(imageUrl: String) {
        if photo != nil && imageUrl != nil && !imageUrl.isEmpty {
            AsyncImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
                self?.photo!.image = image
                print("OK")
            }
        }
    }
}
