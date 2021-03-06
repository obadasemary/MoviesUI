//
//  MainView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import SwiftUI

struct MainView: View {
    
    @State private var currentTab: CustomBottonTabBarTabs = .heart
    
    var body: some View {
        
        TabView {

            MovieListView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Browse")
                }

            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            WatchListView()
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Watchlist")
                }

            FavoriteListView()
                .tabItem {
                    Image(systemName: "bolt.heart.fill")
                    Text("Favoritelist")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: CustomBottonTabBarTabs.person.rawValue)
                    Text("Profile")
                }
        }
        
//        ZStack {
//            Color.black
//            VStack {
//
//                Spacer()
//
//                switch currentTab {
//                case .movies:
//                    MovieListView()
//                case .heart:
//                    WatchListView()
//                case .person:
//                    ProfileView()
//                default:
//                    EmptyView()
//                }
//
//                Spacer()
//
//                CustomBottonTabBar(currentTab: $currentTab, tabs: [.movies, .heart, .person])
//            }
//            .padding(.bottom, 40)
//        }
//        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
