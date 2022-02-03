//
//  LoginVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 16.12.2020.
//

import Foundation
import Combine
import SwiftUI

class LoginVM: ObservableObject {

    @Environment(\.openURL) var openURL
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var tokenState = LoadingState<TokenResponse>.idle
    @Published var tokenResponse: TokenResponse?
    @Published var createSessionState = LoadingState<CreateSessionResponse>.idle
    @Published var createSessionResponse: CreateSessionResponse?
    @Published var profileState = LoadingState<ProfileResponse>.idle
    @Published var profileResponse: ProfileResponse?
    
    @Published var username: String? = UserDefaultsManager.shared.username
    @Published var password: String? = UserDefaultsManager.shared.password

    var is3rdPartyAuthenticationRequestAccepted: Bool {
        UserDefaultsManager.shared.is3rdPartyAuthenticationRequestAccepted
    }
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }
    
    func createRequestToken() {
        
        guard self.tokenState != .loading else { return }
        self.tokenState = .loading
        
        self.repo.createRequestToken()
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output createRequestToken", output)
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
                    self.tokenState = .idle
                case .failure(let error):
                    self.tokenState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.tokenState = .loaded(model)
                self.tokenResponse = model

                // I know this is not the correct implementation but I want to just fix the issue and move on

                if !self.is3rdPartyAuthenticationRequestAccepted {
                    UserDefaultsManager.shared.is3rdPartyAuthenticationRequestAccepted = true
                    print("https://www.themoviedb.org/authenticate/\(self.tokenResponse?.requestToken ?? "")")
                    self.openURL(URL(string: "https://www.themoviedb.org/authenticate/\(self.tokenResponse?.requestToken ?? "https://www.apple.com")")!)
                } else {
                    return
                }

            }.store(in: &cancellables)
    }
    
    func login() {
        
        guard let username = username, let password = password, let requestToken = tokenResponse?.requestToken  else { return }

        UserDefaultsManager.shared.username = username
        UserDefaultsManager.shared.password = password

        print(username, password, requestToken)
        
        self.repo.createSessionWithLogin(username: username, password: password, requestToken: requestToken)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output createSessionWithLogin", output)
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
                    self.tokenState = .idle
                case .failure(let error):
                    self.tokenState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.tokenState = .loaded(model)
                self.tokenResponse = model
                
            }.store(in: &cancellables)
    }
    
    func createSession() {
        
        guard let username = username, let password = password, let requestToken = tokenResponse?.requestToken  else { return }
        
        print(username, password, requestToken)
        
        self.repo.createSession(requestToken: requestToken)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output createSession", output)
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
                    self.createSessionState = .idle
                case .failure(let error):
                    self.createSessionState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.createSessionState = .loaded(model)
                self.createSessionResponse = model
                
                guard let sessionId = model.sessionID else { return }
                
                self.saveSessionId(sessionId: sessionId)
                
            }.store(in: &cancellables)
    }
    
    func login(fUsername: String, fPassword: String) {
        
        guard let requestToken = tokenResponse?.requestToken  else { return }
        
        print(fUsername, fPassword, requestToken)
        
        self.repo.createSessionWithLogin(username: fUsername, password: fPassword, requestToken: requestToken)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output createSessionWithLogin", output)
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
                    self.tokenState = .idle
                case .failure(let error):
                    self.tokenState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.tokenState = .loaded(model)
                self.tokenResponse = model
                
            }.store(in: &cancellables)
    }
    
    func getAccountDetails() {
        
        guard let sessionId = AuthorizationDataManager.shared.getAuthorizationSession() else { return }
        
        self.repo.getAccountDetails(sessionId: sessionId)
            .handleEvents(receiveSubscription: { (sub) in
                print("sub", sub)
            }, receiveOutput: { (output) in
                print("output getAccountDetails", output)
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
                    self.profileState = .idle
                case .failure(let error):
                    self.profileState = .failed(error)
                }
            } receiveValue: { [weak self] (model) in
                
                guard let self = self else { return }
                
                self.profileState = .loaded(model)
                self.profileResponse = model
                
                self.saveAuthorizationProfile(model: model)
                
            }.store(in: &cancellables)
    }
    
    func saveSessionId(sessionId: String) {
        
        AuthorizationDataManager.shared.saveAuthorizationSession(sessionId: sessionId)
    }
    
    func saveAuthorizationProfile(model: ProfileResponse) {
        
        AuthorizationDataManager.shared.saveAuthorizationProfile(model: model)
    }
}
