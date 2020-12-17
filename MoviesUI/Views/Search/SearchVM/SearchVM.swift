//
//  SearchVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 14.12.2020.
//

import Foundation
import Combine

class SearchVM: ObservableObject, LoadableObject {
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var state = LoadingState<[Movie]>.idle
    @Published var moviesResponse: MovieListResponse?
    
    @Published var movies: [Movie] = []
    
    var movieName: String = ""
    var moviesPage: Int = 1
    var moviesTotalPages: Int = 0
    @Published var moviesIsLoadingPage = false
    var moviesCanLoadMorePages = true
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    func load() {
        search(movieName: self.movieName)
    }
    
    func loadMoreContentIfNeeded(currentItem item: Movie?, movieName: String) {
        
        guard let item = item else {
            search(movieName: movieName)
//            load()
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            search(movieName: movieName)
//            load()
        }
    }
    
    func search(movieName: String) {
        
        guard !moviesIsLoadingPage && moviesCanLoadMorePages else {
            return
        }
        
        if movieName.isEmpty {
            return
        }
        
        moviesIsLoadingPage = true
        
        guard self.state != .loading else { return }
        self.state = .loading
        
        self.repo.search(query: movieName, page: moviesPage)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output search", output)
            }, receiveCompletion: { (c) in
                print("completion", c)
            }, receiveCancel: {
                print("cancel is recieved")
            }, receiveRequest: { (request) in
                print("request", request)
            })
            
            .sink { (completion) in
                switch completion {
                case .finished: ()
//                    self.state = .idle
                case .failure(let error):
                    self.state = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.moviesPage += 1
                self.moviesIsLoadingPage = false
                self.moviesResponse = model
                self.movies.append(contentsOf: model.results ?? [])
                self.state = .loaded(self.movies)
                self.moviesTotalPages = model.totalPages ?? 0
                self.moviesCanLoadMorePages = self.moviesPage <= self.moviesTotalPages
                
            }.store(in: &cancellables)
    }
}
