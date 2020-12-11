//
//  MovieView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 8.12.2020.
//

import SwiftUI

struct MovieView: View {
    
    var movie: Movie
    
    var body: some View {
        VStack {
            
            kfImageView(url: URLBuilder.imageUrl(path: movie.posterPath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png") ?? "")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(movie.title ?? "")
                        .font(.system(.title))
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(movie.releaseDate?.uppercased() ?? "")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                
                Spacer()
            }
            .padding([.horizontal, .top])
            
            Group {
                
//                HStack(spacing: 3) {
//
//                    RatingView(rating: Int(movie.voteAverage))
//                        .cornerRadius(10)
//                        .padding()
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.accentColor, lineWidth: 1)
//                        )
//
//                    Spacer()
//
////                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
////                        Image(systemName: CustomBottonTabBarTabs.plus.rawValue)
////                            .resizable()
////                            .frame(width: 26, height: 26, alignment: .center)
////                            .foregroundColor(.accentColor)
////                    })
//                }
            
                RatingView(rating: Int(movie.voteAverage ?? 0))
                    .cornerRadius(10)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                
                Text(movie.overview ?? "")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.accentColor, lineWidth: 1)
        )
        .padding()
    }
}

struct MovieView_Previews: PreviewProvider {

    static let topRatedMovieListResponse: MovieListResponse = Bundle.main.decode("topRatedMovieListResponse.json")

    static var previews: some View {
        MovieView(movie: (topRatedMovieListResponse.results?[4])!)
    }
}
