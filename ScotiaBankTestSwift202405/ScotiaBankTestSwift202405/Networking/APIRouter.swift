//
//  APIRouter.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 28/05/24.
//

import Foundation

class APIConstant {
    static let shared = APIConstant()
    
    let URLStringTMDB = "https://api.themoviedb.org/3/discover/movie?api_key=41bb2316eccb422b9542a10273931559"
    let URLStringPoster = "https://image.tmdb.org/t/p/original"
}

enum APIRouter {
    case getData
    
    var urlRequest: URLRequest {
        switch self {
        case .getData:
            return URLRequest(url: URL(string: APIConstant.shared.URLStringTMDB)!)
        }
    }
}
