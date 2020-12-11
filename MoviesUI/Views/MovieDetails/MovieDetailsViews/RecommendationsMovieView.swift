//
//  RecommendationsMovieView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 10.12.2020.
//

import SwiftUI

struct RecommendationsMovieView: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            kfImageView(url: URLBuilder.imageUrl(path: movie.backdropPath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png") ?? "")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(12)
            
            Text(movie.title ?? "")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .lineLimit(3)
        }
    }
}

struct RecommendationsMovieView_Previews: PreviewProvider {
    
    static let topRatedMovieListResponse: MovieListResponse = Bundle.main.decode("topRatedMovieListResponse.json")
    
    static var previews: some View {
        RecommendationsMovieView(movie: (topRatedMovieListResponse.results?[4])!)
            .preferredColorScheme(.light)
    }
}
