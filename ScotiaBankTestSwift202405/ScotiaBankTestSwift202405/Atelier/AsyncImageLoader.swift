//
//  AsyncImageLoader.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 23/05/24.
//

import Foundation
import UIKit

class AsyncImageLoader {
   
    static let shared = AsyncImageLoader()
    private var imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            self.imageCache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
