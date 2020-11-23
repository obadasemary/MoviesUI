//
//  MainView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import SwiftUI

struct MainView: View {
    
    @State private var currentTab: CustomBottonTabBarTabs = .movies
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                
                Spacer()
                
                switch currentTab {
                case .movies:
                    MovieListView()
                case .heart:
                    ProfileView()
                case .person:
                    WishListView()
                default:
                    EmptyView()
                }
                
                Spacer()
                
                CustomBottonTabBar(currentTab: $currentTab, tabs: [.movies, .heart, .person])
            }
            .padding(.bottom, 40)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
