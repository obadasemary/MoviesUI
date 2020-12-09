//
//  MoviesView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 8.12.2020.
//

import SwiftUI

struct MoviesView: View {
    
    var movies: [Movie] = []
    
    var body: some View {
        ForEach(movies) { movie in
            MovieView(movie: movie)
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    
    static let topRatedMovieListResponse: MovieListResponse = Bundle.main.decode("topRatedMovieListResponse.json")
    
    static var previews: some View {
        MoviesView(movies: topRatedMovieListResponse.results ?? [])
    }
}
