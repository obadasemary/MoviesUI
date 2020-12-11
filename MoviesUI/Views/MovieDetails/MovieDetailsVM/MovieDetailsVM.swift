//
//  MovieDetailsVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 10.12.2020.
//

import Foundation
import Combine

class MovieDetailsVM: ObservableObject {
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var movieState = LoadingState<Movie>.idle
    @Published var movie: Movie?
    @Published var movieId: Int?
    
    @Published var galleryState = LoadingState<MovieGallery>.idle
    @Published var movieGallery: MovieGallery?
    
    @Published var recommendationsState = LoadingState<MovieListResponse>.idle
    @Published var recommendationsMoviesResponse: MovieListResponse?
    @Published var recommendationsMovies: [Movie] = []
    
    var recommendationsMoviesPage: Int = 1
    var recommendationsMoviesTotalPages: Int = 0
    @Published var recommendationsMoviesIsLoadingPage = false
    private var recommendationsMoviesCanLoadMorePages = true
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    func getMovieDetails(movieId: Int) {
        
        guard self.movieState != .loading else { return }
        self.movieState = .loading
        
        self.repo.getMovieDetails(movieId: movieId)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getMovieDetails", output)
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
                    self.movieState = .idle
                case .failure(let error):
                    self.movieState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.movieState = .loaded(model)
                self.movie = model
                
            }.store(in: &cancellables)
    }
    
    func getMovieGallery(movieId: Int) {
        
        guard self.galleryState != .loading else { return }
        self.galleryState = .loading
        
        self.repo.getMovieGallery(movieId: movieId)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getMovieDetails", output)
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
                    self.galleryState = .idle
                case .failure(let error):
                    self.galleryState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.galleryState = .loaded(model)
                self.movieGallery = model
                
            }.store(in: &cancellables)
    }
    
    func loadMoreContentIfNeeded(currentItem item: Movie?, movieId: Int) {
        
        guard let item = item else {
            getRecommendationsMovieList(movieId: movieId)
            return
        }
        
        let thresholdIndex = recommendationsMovies.index(recommendationsMovies.endIndex, offsetBy: -5)
        if recommendationsMovies.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            print("recommendationsMovieId", self.movieId)
            getRecommendationsMovieList(movieId: self.movieId ?? 122)
        }
    }
    
    func getRecommendationsMovieList(movieId: Int) {
        
        guard !recommendationsMoviesIsLoadingPage && recommendationsMoviesCanLoadMorePages else {
            return
        }
        
        recommendationsMoviesIsLoadingPage = true
        
        guard self.recommendationsState != .loading else { return }
        self.recommendationsState = .loading
        
        self.repo.getRecommendationsMovieList(movieId: movieId)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getRecommendationsMovieList", output)
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
                    self.recommendationsState = .idle
                case .failure(let error):
                    self.recommendationsState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.recommendationsState = .loaded(model)
                self.recommendationsMoviesPage += 1
                self.recommendationsMoviesIsLoadingPage = false
                self.recommendationsMoviesResponse = model
                self.recommendationsMovies.append(contentsOf: model.results ?? [])
                self.recommendationsMoviesTotalPages = model.totalPages ?? 0
                self.recommendationsMoviesCanLoadMorePages = self.recommendationsMoviesPage <= self.recommendationsMoviesTotalPages
                
            }.store(in: &cancellables)
    }
}
