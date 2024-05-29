//
//  TMDBViewModel.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 23/05/24.
//

import Foundation

protocol TMDBViewModelProtocol {
    func fetchData() throws
    func getData(filterMovies: Handler, order: MovieOrder, filter: String) -> [Movie]
    func orderData(moviesForOrder: [Movie], order: MovieOrder, filter: String) -> [Movie]
}

class TMDBViewModel: TMDBViewModelProtocol {

    var useCase: TMDBUseCaseProtocol
    
    init(useCase: TMDBUseCaseProtocol = TMDBUseCase()) {
        self.useCase = useCase
    }
    
    func fetchData() throws {
        let semaphore = DispatchSemaphore(value: 0)
        Task {
            do {
                try await useCase.fetchData()
            } catch {
                throw ScotiaBankError.whenViewModel
            }
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    func getData(filterMovies: Handler, order: MovieOrder, filter: String) -> [Movie] {
        return useCase.getData(filterForMovies: filterMovies, order: order, filter: filter)
    }
    
    func orderData(moviesForOrder: [Movie], order: MovieOrder, filter: String) -> [Movie] {
        return useCase.orderData(moviesForOrder: moviesForOrder, order: order, filter: filter)
    }
}
