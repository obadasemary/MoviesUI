//
//  WatchListVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 17.12.2020.
//

import Foundation
import Combine

class WatchListVM: ObservableObject {
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var state = LoadingState<[Movie]>.idle
    @Published var moviesResponse: MovieListResponse?
    
    @Published var movies: [Movie] = []
    
    var moviesPage: Int = 1
    var moviesTotalPages: Int = 0
    @Published var moviesIsLoadingPage = false
    var moviesCanLoadMorePages = true
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    func loadMoreContentIfNeeded(currentItem item: Movie?) {
        
        guard let item = item else {
            getMovieWatchlist()
            return
        }
        
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if movies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            getMovieWatchlist()
        }
    }

    func getMovieWatchlist() {
        
        guard let sessionId = AuthorizationDataManager.shared.getAuthorizationSession() else { return }
        guard let profileResponse = AuthorizationDataManager.shared.getAuthorizationProfile(), let accountId = profileResponse.id else { return }
        
        guard !moviesIsLoadingPage && moviesCanLoadMorePages else {
            return
        }
        
        moviesIsLoadingPage = true
        
        guard self.state != .loading else { return }
        self.state = .loading
        
        self.repo.getMovieWatchlist(page: moviesPage, sessionId: sessionId, accountId: accountId)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getMovieWatchlist", output)
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
