//
//  MovieListVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 18.11.2020.
//

import Foundation
import Combine

class MovieListVM: ObservableObject {
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var state = LoadingState<MovieListResponse>.idle
    @Published var topRatedMoviesResponse: MovieListResponse?
    @Published var upcomingMoviesResponse: MovieListResponse?
    @Published var nowPlayingMoviesResponse: MovieListResponse?
    @Published var popularMoviesResponse: MovieListResponse?
    
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    
    @Published var currentTab: CustomTab = .topRated
    
    var topRatedMoviesPage: Int = 1
    var topRatedMoviesTotalPages: Int = 0
    @Published var topRatedMoviesIsLoadingPage = false
    private var topRatedMoviesCanLoadMorePages = true
    
    var upcomingMoviesPage: Int = 1
    var upcomingMoviesTotalPages: Int = 0
    @Published var upcomingMoviesIsLoadingPage = false
    private var upcomingMoviesCanLoadMorePages = true
    
    var nowPlayingMoviesPage: Int = 1
    var nowPlayingMoviesTotalPages: Int = 0
    @Published var nowPlayingMoviesIsLoadingPage = false
    private var nowPlayingMoviesCanLoadMorePages = true
    
    var popularMoviesPage: Int = 1
    var popularMoviesTotalPages: Int = 0
    @Published var popularMoviesIsLoadingPage = false
    private var popularMoviesCanLoadMorePages = true
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    func loadMoreContentIfNeeded(currentItem item: Movie?, currentTab: CustomTab) {
        
        switch currentTab {
        case .topRated:
            guard let item = item else {
                getTopRatedMovieList()
                return
            }
            
            let thresholdIndex = topRatedMovies.index(topRatedMovies.endIndex, offsetBy: -5)
            if topRatedMovies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
                getTopRatedMovieList()
            }
        case .upcoming:
            guard let item = item else {
                getUpcomingMovieList()
                return
            }
            
            let thresholdIndex = upcomingMovies.index(upcomingMovies.endIndex, offsetBy: -5)
            if upcomingMovies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
                getUpcomingMovieList()
            }
        case .nowPlaying:
            guard let item = item else {
                getNowPlayingMovieList()
                return
            }
            
            let thresholdIndex = nowPlayingMovies.index(nowPlayingMovies.endIndex, offsetBy: -5)
            if nowPlayingMovies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
                getNowPlayingMovieList()
            }
        case .popular:
            guard let item = item else {
                getPopularMovieList()
                return
            }
            
            let thresholdIndex = popularMovies.index(popularMovies.endIndex, offsetBy: -5)
            if popularMovies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
                getPopularMovieList()
            }
        }
    }
    
    func getTopRatedMovieList() {
        
        guard !topRatedMoviesIsLoadingPage && topRatedMoviesCanLoadMorePages else {
            return
        }
        
        topRatedMoviesIsLoadingPage = true
        
        guard self.state != .loading else { return }
        self.state = .loading
        
        self.repo.getTopRatedMovieList(page: topRatedMoviesPage)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getTopRatedMovieList", output)
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
                self.topRatedMoviesPage += 1
                self.topRatedMoviesIsLoadingPage = false
                self.topRatedMoviesResponse = model
                self.topRatedMovies.append(contentsOf: model.results ?? [])
                self.topRatedMoviesTotalPages = model.totalPages ?? 0
                self.topRatedMoviesCanLoadMorePages = self.topRatedMoviesPage <= self.topRatedMoviesTotalPages
                
            }.store(in: &cancellables)
    }
    
    func getUpcomingMovieList() {
        
        guard !upcomingMoviesIsLoadingPage && upcomingMoviesCanLoadMorePages else {
            return
        }
        
        upcomingMoviesIsLoadingPage = true
        
        guard self.state != .loading else { return }
        self.state = .loading
        
        self.repo.getUpcomingMovieList(page: upcomingMoviesPage)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getUpcomingMovieList", output)
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
                self.upcomingMoviesPage += 1
                self.upcomingMoviesIsLoadingPage = false
                self.upcomingMoviesResponse = model
                self.upcomingMovies.append(contentsOf: model.results ?? [])
                self.upcomingMoviesTotalPages = model.totalPages ?? 0
                self.upcomingMoviesCanLoadMorePages = self.upcomingMoviesPage <= self.upcomingMoviesTotalPages
                
            }.store(in: &cancellables)
    }
    
    func getNowPlayingMovieList() {
        
        guard !nowPlayingMoviesIsLoadingPage && nowPlayingMoviesCanLoadMorePages else {
            return
        }
        
        nowPlayingMoviesIsLoadingPage = true
        
        guard self.state != .loading else { return }
        self.state = .loading
        
        self.repo.getNowPlayingMovieList(page: nowPlayingMoviesPage)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getNowPlayingMovieList", output)
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
                self.nowPlayingMoviesPage += 1
                self.nowPlayingMoviesIsLoadingPage = false
                self.nowPlayingMoviesResponse = model
                self.nowPlayingMovies.append(contentsOf: model.results ?? [])
                self.nowPlayingMoviesTotalPages = model.totalPages ?? 0
                self.nowPlayingMoviesCanLoadMorePages = self.nowPlayingMoviesPage <= self.nowPlayingMoviesTotalPages
                
            }.store(in: &cancellables)
    }
    
    func getPopularMovieList() {
        
        guard !popularMoviesIsLoadingPage && popularMoviesCanLoadMorePages else {
            return
        }
        
        popularMoviesIsLoadingPage = true
        
        guard self.state != .loading else { return }
        self.state = .loading
        
        self.repo.getPopularMovieList(page: popularMoviesPage)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getPopularMovieList", output)
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
                self.popularMoviesPage += 1
                self.popularMoviesIsLoadingPage = false
                self.popularMoviesResponse = model
                self.popularMovies.append(contentsOf: model.results ?? [])
                self.popularMoviesTotalPages = model.totalPages ?? 0
                self.popularMoviesCanLoadMorePages = self.popularMoviesPage <= self.popularMoviesTotalPages
                
            }.store(in: &cancellables)
    }
}
