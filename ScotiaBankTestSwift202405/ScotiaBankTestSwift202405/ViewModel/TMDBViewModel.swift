//
//  TMDBViewModel.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 23/05/24.
//

import Foundation

protocol TMDBViewModelProtocol {
    func fetchData()
    func getData(singleton: Singleton, order: MovieOrder, filter: String) -> [Movie]
}

class TMDBViewModel: TMDBViewModelProtocol {

    var useCase: TMDBUseCaseProtocol
    
    init(useCase: TMDBUseCaseProtocol = TMDBUseCase()) {
        self.useCase = useCase
    }
    
    func fetchData() {
        let semaphore = DispatchSemaphore(value: 0)
        Task {
            try await useCase.fetchData()
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    func getData(singleton: Singleton, order: MovieOrder, filter: String) -> [Movie] {
        return useCase.getData(singleton: singleton, order: order, filter: filter)
    }
}
