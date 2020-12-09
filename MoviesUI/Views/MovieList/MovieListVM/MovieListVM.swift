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
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var state = LoadingState<MovieListResponse>.idle
    @Published var movieResponse: MovieListResponse?
    @Published var topRatedMovies: [Movie] = []
    
    var totalPages: Int = 0
    var page: Int = 403
    var movieListFull = false
    @Published var isLoadingPage = false
    private var canLoadMorePages = true
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    //    func load() {
    //
    //        getTopRatedMovieList()
    //    }
    
    func loadMoreContentIfNeeded(currentItem item: Movie?) {
        guard let item = item else {
            getTopRatedMovieList()
            return
        }
        
        let thresholdIndex = topRatedMovies.index(topRatedMovies.endIndex, offsetBy: -5)
        if topRatedMovies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            getTopRatedMovieList()
        }
    }
    
    func getTopRatedMovieList() {
        
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        
        isLoadingPage = true
        
        guard self.state != .loading else { return }
        self.state = .loading
        
        self.repo.getTopRatedMovieList(page: page)
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
                    self.state = .idle
                case .failure(let error):
                    self.state = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                self.state = .loaded(model)
                self.page += 1
                self.isLoadingPage = false
                self.movieResponse = model
                self.topRatedMovies.append(contentsOf: model.results ?? [])
                self.totalPages = model.totalPages ?? 0
//                self.canLoadMorePages =  model.totalPages
                self.canLoadMorePages = self.page <= self.totalPages
//                if self.totalPages <= self.page {
//                    self.canLoadMorePages = false
//                }
                
//                if self.topRatedMovies.count < self.totalPages || self.topRatedMovies.count == 0 {
//                    self.movieListFull = true
//                }
                
            }.store(in: &cancellables)
    }
}
