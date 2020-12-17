//
//  MovieView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 8.12.2020.
//

import SwiftUI

struct MovieView: View {
    
    @ObservedObject var addToListVM = AddToListVM(repo: Injector.mainServiceRepo)
    var movie: Movie
    
    var body: some View {
        VStack {
            
            ZStack {
                kfImageView(url: URLBuilder.imageUrl(path: movie.posterPath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png") ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                UserScoreView(progress: CGFloat(movie.voteAverage ?? 0), boxSize: 70)
                    .offset(x: UIScreen.main.bounds.width / 3.5 , y: 280)
            }
            
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
                
                AddToListView(movieId: movie.id ?? 155, movieName: movie.title ?? "", doWeNeedSpacer: true)
                    .environmentObject(self.addToListVM)
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
