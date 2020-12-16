//
//  SearchMoviesView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 14.12.2020.
//

import SwiftUI

struct SearchMoviesView: View {
    
    @EnvironmentObject var vm: SearchVM
    var movies: [Movie] = []
    var queryMovieName: String
    
    var body: some View {
        LazyVStack {
            ForEach(movies) { movie in
                NavigationLink(destination: MovieDetailsView(movieId: movie.id ?? 27205)) {
                    MovieView(movie: movie)
                        .onAppear {
                            self.vm.loadMoreContentIfNeeded(currentItem: movie, movieName: queryMovieName)
                        }
                }
            }
        }
    }
}

struct SearchMoviesView_Previews: PreviewProvider {
    
    static let topRatedMovieListResponse: MovieListResponse = Bundle.main.decode("topRatedMovieListResponse.json")
    
    static var previews: some View {
        SearchMoviesView(movies: topRatedMovieListResponse.results ?? [], queryMovieName: "Avengers")
    }
}
