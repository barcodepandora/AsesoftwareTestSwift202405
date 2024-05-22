//
//  TMDB.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 22/05/24.
//

import Foundation

struct TMDB {
    var page: Int?
    
    init(page: Int? = nil) {
        self.page = page
    }
}

extension TMDB: Decodable {}
