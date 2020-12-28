//
//  MoviesView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 8.12.2020.
//

import SwiftUI

struct MoviesView: View {
    
    @EnvironmentObject var vm: MovieListVM
    var movies: [Movie] = []
    var currentTab: CustomTab
    
    var body: some View {
        LazyVStack {
            ForEach(movies) { movie in
                NavigationLink(destination: MovieDetailsView(movieId: movie.id ?? 27205)) {
                    MovieView(movie: movie)
                        .onAppear {
                            self.vm.loadMoreContentIfNeeded(currentItem: movie, currentTab: currentTab)
                        }
                }
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    
    static let topRatedMovieListResponse: MovieListResponse = Bundle.main.decode("topRatedMovieListResponse.json")
    
    static var previews: some View {
        MoviesView(movies: topRatedMovieListResponse.results ?? [], currentTab: .popular)
    }
}
