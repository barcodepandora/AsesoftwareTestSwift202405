//
//  TMDBUseCase.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 22/05/24.
//

import Foundation

protocol TMDBUseCaseProtocol {
    func deliverMovies() async throws -> TMDB
}

class TMDBUseCase: TMDBUseCaseProtocol {
    func deliverMovies() async throws -> TMDB {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=41bb2316eccb422b9542a10273931559")!)
        let decoder = JSONDecoder()
        let aTMDB = try decoder.decode(TMDB.self, from: data)
        return aTMDB
    }
}
