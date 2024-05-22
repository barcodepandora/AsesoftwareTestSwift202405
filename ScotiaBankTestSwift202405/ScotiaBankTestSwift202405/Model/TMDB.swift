//
//  TMDB.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 22/05/24.
//

import Foundation

struct TMDB {
    var page: Int?
    var results: [Movie]?
    
    init(page: Int? = nil, results: [Movie] = []) {
        self.page = page
        self.results = results
    }
}

extension TMDB: Decodable {
    
}

struct Movie {
    var adult: Bool?
    var backdrop_path: String?
    var id: Int?
    var original_language: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?

    init(adult: Bool? = nil, backdrop_path: String? = nil, id: Int? = nil, original_language: String? = nil, overview: String? = nil, popularity: Double? = nil, poster_path: String? = nil, release_date: String? = nil, title: String? = nil, video: Bool? = nil, vote_average: Double? = nil, vote_count: Int? = nil) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.id = id
        self.original_language = original_language
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}

extension Movie: Decodable {
    
}
