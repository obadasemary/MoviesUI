//
//  MovieListView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 16.11.2020.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var vm = MovieListVM(repo: Injector.mainServiceRepo)
    
    var body: some View {
        NavigationView {
            
            VStack {
                CustomTabsView(currentTab: self.$vm.currentTab, tabs: [.topRated, .upcoming, .nowPlaying, .popular])
                    .onReceive(self.vm.$currentTab, perform: { currentValue in
                        
                        switch currentValue {
                        
                        case .upcoming:
                            self.vm.getUpcomingMovieList()
                        case .nowPlaying:
                            self.vm.getNowPlayingMovieList()
                        case .popular:
                            self.vm.getPopularMovieList()
                        default:
                            return
                        }
                    })
                
                ScrollView {
                    VStack {
                        
                        switch vm.currentTab {
                        
                        case .topRated:
                            MoviesView(movies: vm.topRatedMovies, currentTab: .topRated)
                                .environmentObject(self.vm)
                        case .upcoming:
                            MoviesView(movies: vm.upcomingMovies, currentTab: .upcoming)
                                .environmentObject(self.vm)
                        case .nowPlaying:
                            MoviesView(movies: vm.nowPlayingMovies, currentTab: .nowPlaying)
                                .environmentObject(self.vm)
                        case .popular:
                            MoviesView(movies: vm.popularMovies, currentTab: .popular)
                                .environmentObject(self.vm)
                        }
                    }
                }
            }
            .navigationBarTitle("Movies", displayMode: .large)
        }
        .onAppear {
            self.vm.getTopRatedMovieList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
