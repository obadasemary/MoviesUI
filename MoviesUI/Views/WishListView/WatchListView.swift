//
//  WatchListView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import SwiftUI

struct WatchListView: View {
    
    @ObservedObject var vm = WatchListVM(repo: Injector.mainServiceRepo)
    
    var body: some View {
        NavigationView {
            VStack {
                //                AsyncContentView(source: vm) { _ in
                ScrollView {
                    LazyVStack {
                        ForEach(vm.movies) { movie in
                            NavigationLink(destination: MovieDetailsView(movieId: movie.id ?? 27205)) {
                                MovieView(movie: movie)
                                    .onAppear {
                                        self.vm.loadMoreContentIfNeeded(currentItem: movie)
                                    }
                            }
                        }
                    }
                }
                //                }
            }
            .navigationBarTitle("WatchList", displayMode: .large)
        }
        .onAppear {
            self.vm.getMovieWatchlist()
        }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
