//
//  PictureViewController.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 23/05/24.
//

import UIKit

class PictureViewController: ViewController {

    @IBOutlet weak var picture: UIImageView!
    
    var urlPicture: String?
    
    convenience init(urlPicture: String) {
        self.init()
        self.urlPicture = urlPicture
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageUrl = urlPicture ?? ""
        AsyncImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
            self?.picture.image = image
        }
    }

    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
