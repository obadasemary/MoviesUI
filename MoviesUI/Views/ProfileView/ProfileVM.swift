//
//  ProfileVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 16.12.2020.
//

import Foundation
import ProfileVM

class LoginVM: ObservableObject {
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var tokenState = LoadingState<TokenResponse>.idle
    @Published var tokenResponse: TokenResponse?
    @Published var createSessionState = LoadingState<CreateSessionResponse>.idle
    @Published var createSessionResponse: CreateSessionResponse?
    
    
    @Published var username: String? = "Obada.semary"
    @Published var password: String? = "Admin123"
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }

}
