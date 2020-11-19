//
//  MovieListVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation

import Combine

class MovieListVM: ObservableObject {
    
//    var movieListVM = MovieListVM(repo: Injector.mainServiceRepo)
    let repo: MainServicesRepoType
    @Published var movieResponse: MovieResponse?
    private var cancellables: Set<AnyCancellable> = []
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    func load() {
        
        self.repo.getCountriesWithCities()
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output", output)
            }, receiveCompletion: { (c) in
                print("completion", c)
            }, receiveCancel: {
                print("cancel is recieved")
            }, receiveRequest: { (request) in
                print("request", request)
            })
            
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("-> getUserAddresses", completion)
                case .failure:
                    print("-> failureGetUserAddresses", completion)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.movieResponse = model
                
            }.store(in: &cancellables)
        
    }
}
