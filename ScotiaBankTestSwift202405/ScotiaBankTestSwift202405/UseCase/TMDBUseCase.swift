//
//  TMDBUseCase.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 22/05/24.
//

import Foundation

protocol TMDBUseCaseProtocol {
    func fetchData() async throws -> [Movie]
    func getData(filterMovies: Handler, order: MovieOrder, filter: String) -> [Movie]
}

class TMDBUseCase: TMDBUseCaseProtocol {
    
    var movies: [Movie]?
    
    func fetchData() async throws -> [Movie] {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=41bb2316eccb422b9542a10273931559")!)
        let decoder = JSONDecoder()
        let aTMDB = try decoder.decode(TMDB.self, from: data)
        movies = aTMDB.results
        return movies!
    }
    
    func getData(filterMovies: Handler, order: MovieOrder, filter: String) -> [Movie] {
        var moviesThosePresent = filter.isEmpty ? movies : movies!.filter { $0.title!.contains(filter) }
        
        switch filterMovies.adult {
        case .allMinusAdult:
            moviesThosePresent = moviesThosePresent!.filter { $0.adult == false }
        case .adult:
            moviesThosePresent = moviesThosePresent!.filter { $0.adult == true }
        case .all:
            break
        }
        
        switch filterMovies.language {
        case .english:
            moviesThosePresent = moviesThosePresent!.filter { $0.original_language == "en" }
        case .francaise:
            moviesThosePresent = moviesThosePresent!.filter { $0.original_language == "fr" }
        case .all:
            break
        }
        
        switch filterMovies.average {
        case .lessThan5K:
            moviesThosePresent = moviesThosePresent!.filter { $0.vote_average! <= 7 }
        case .moreThan5K:
            moviesThosePresent = moviesThosePresent!.filter { $0.vote_average! > 7 }
        case .all:
            break
        }
        
        switch order {
        case .popularity:
            moviesThosePresent = moviesThosePresent!.sorted { $0.popularity! > $1.popularity! }
        case .topRated:
            moviesThosePresent = moviesThosePresent!.sorted { $0.vote_count! > $1.vote_count! }
        }
        
        return moviesThosePresent!
    }
}
