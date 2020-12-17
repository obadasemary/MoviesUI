//
//  SearchView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 14.12.2020.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var vm = SearchVM(repo: Injector.mainServiceRepo)
    @State private var movieName: String = ""
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.accentColor)
                    
                    TextField("Search", text: $movieName) { _ in
                        
                    } onCommit: {
                        self.vm.moviesPage = 1
                        self.vm.moviesIsLoadingPage = false
                        self.vm.moviesCanLoadMorePages = true
                        self.vm.movies = []
                        self.vm.movieName = self.movieName
                        self.vm.load()
//                        search(movieName: self.movieName)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            Color.accentColor,
                            lineWidth: 1
                        )
                )
                .padding()
                
                Spacer()
                
                AsyncContentView(source: vm) { _ in
                    ScrollView {
//                        LazyVStack {
                            SearchMoviesView(movies: vm.movies, queryMovieName: self.movieName)
                                .environmentObject(self.vm)
                            
//                            HStack {
//                                Spacer()
//                                UIKitActivityIndicator(isAnimating: $isLoading, style: .large)
//                                    .configure { $0.color = UIColor(Color.accentColor) }
//                                Spacer()
//                            }
//                            .onAppear {
//                                self.vm.moviesIsLoadingPage = false
//                                self.vm.moviesCanLoadMorePages = true
//                                self.vm.loadMoreContentIfNeeded(currentItem: vm.movies.last, movieName: self.movieName)
//                            }
//                        }
                    }
                }
                
                Spacer()
            }
            
            .navigationBarTitle("Search", displayMode: .large)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
