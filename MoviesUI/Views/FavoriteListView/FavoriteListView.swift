//
//  FavoriteListView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 17.12.2020.
//

import SwiftUI

struct FavoriteListView: View {
    
    @ObservedObject var vm = FavoriteListVM(repo: Injector.mainServiceRepo)
    
    var body: some View {
        NavigationView {
            VStack {
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
            }
            .navigationBarTitle("FavoriteList", displayMode: .large)
        }
        .onAppear {
            self.vm.getMovieFavoritelist()
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView()
    }
}
