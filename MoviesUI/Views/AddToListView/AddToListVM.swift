//
//  AddToListVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 17.12.2020.
//

import Foundation
import Combine

class AddToListVM: ObservableObject {
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var movieState = LoadingState<Movie>.idle
//    @Published var movieId: Int?
    
    @Published var addToWatchListState = LoadingState<AddToListResponse>.idle
    @Published var addToFavoriteListState = LoadingState<AddToListResponse>.idle
    @Published var addToListResponse: AddToListResponse?
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    func addMovieToWatchList(movieId: Int) {
        
        guard let sessionId = AuthorizationDataManager.shared.getAuthorizationSession() else { return }
        guard let profileResponse = AuthorizationDataManager.shared.getAuthorizationProfile(), let accountId = profileResponse.id else { return }
        
        guard self.addToWatchListState != .loading else { return }
        self.addToWatchListState = .loading
        
        self.repo.addMovieToWatchlist(movieId: movieId, sessionId: sessionId, accountId: accountId)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output addMovieToWatchlist", output)
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
                    self.addToWatchListState = .idle
                case .failure(let error):
                    self.addToWatchListState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.addToWatchListState = .loaded(model)
                self.addToListResponse = model
                
            }.store(in: &cancellables)
    }
    
    func addMovieToFavoritelist(movieId: Int) {
        
        guard let sessionId = AuthorizationDataManager.shared.getAuthorizationSession() else { return }
        guard let profileResponse = AuthorizationDataManager.shared.getAuthorizationProfile(), let accountId = profileResponse.id else { return }
        
        guard self.addToFavoriteListState != .loading else { return }
        self.addToFavoriteListState = .loading
        
        self.repo.addMovieToFavoritelist(movieId: movieId, sessionId: sessionId, accountId: accountId)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output addMovieToFavoritelist", output)
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
                    self.addToFavoriteListState = .idle
                case .failure(let error):
                    self.addToFavoriteListState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.addToFavoriteListState = .loaded(model)
                self.addToListResponse = model
                
            }.store(in: &cancellables)
    }
}
