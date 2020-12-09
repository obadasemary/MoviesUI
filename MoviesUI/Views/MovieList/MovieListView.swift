//
//  MovieListView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 16.11.2020.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var vm = MovieListVM(repo: Injector.mainServiceRepo)
    @State private var isLoading = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(vm.topRatedMovies) { movie in
                        MovieView(movie: movie)
                            .onAppear {
                                self.vm.loadMoreContentIfNeeded(currentItem: movie)
                            }
                    }
                }
            }
            .navigationBarTitle("Movies", displayMode: .large)
            
            if vm.isLoadingPage {
//                ProgressView()
//                UIKitActivityIndicator(isAnimating: .constant(true), style: .medium)
//                    .configure {
//                        $0.color = UIColor.orange
//                    }
                LoadingView()
            }
            //            List(vm.topRatedMovies) { movie in
            //                MovieView(movie: movie)
            //                    .onAppear {
            //                        self.vm.loadMoreContentIfNeeded(currentItem: movie)
            //                    }
            //            }
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
