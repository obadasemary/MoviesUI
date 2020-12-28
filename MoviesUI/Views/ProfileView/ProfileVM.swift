//
//  ProfileVM.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 16.12.2020.
//

import Foundation
import Combine

class ProfileVM: ObservableObject {
    
    let repo: MainServicesRepoType
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var profileState = LoadingState<ProfileResponse>.idle
    @Published var profileResponse: ProfileResponse?
    
    init(repo: MainServicesRepoType) {
        self.repo = repo
    }

    func getAccountDetails() {
        
        guard AuthorizationDataManager.shared.getAuthorizationSession() != nil else { return }
        guard let profileResponse = AuthorizationDataManager.shared.getAuthorizationProfile() else { return }
        self.profileResponse = profileResponse
    }
}
