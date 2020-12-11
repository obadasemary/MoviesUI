//
//  RecommendationsMoviesView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 10.12.2020.
//

import SwiftUI

struct RecommendationsMoviesView: View {
    
    @EnvironmentObject var vm: MovieDetailsVM
    var movies: [Movie] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 15) {
                ForEach(movies, id: \.self) { movie in
                    NavigationLink(destination: MovieDetailsView(movieId: movie.id ?? 27205)) {
                        RecommendationsMovieView(movie: movie)
                            .onAppear {
                                self.vm.loadMoreContentIfNeeded(currentItem: movie, movieId: movie.id ?? 27205)
                            }
                    }
                }
            }
            .padding()
        }
    }
}

struct RecommendationsMoviesView_Previews: PreviewProvider {
    
    static let recommendationsMovieListResponse: MovieListResponse = Bundle.main.decode("topRatedMovieListResponse.json")
    
    static var previews: some View {
        RecommendationsMoviesView(movies: recommendationsMovieListResponse.results ?? [])
    }
}
