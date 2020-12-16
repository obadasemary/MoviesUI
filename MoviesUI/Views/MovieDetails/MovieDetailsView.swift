//
//  MovieDetailsView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 10.12.2020.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @ObservedObject var vm = MovieDetailsVM(repo: Injector.mainServiceRepo)
    let movieId: Int
    
    var body: some View {
        ScrollView {
            VStack {
                
                kfImageView(url: URLBuilder.imageUrl(path: vm.movie?.posterPath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png") ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(vm.movie?.title ?? "")
                            .font(.system(.title))
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text(vm.movie?.releaseDate?.uppercased() ?? "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                if let movieGallery = vm.movieGallery {
                    
                    // Backdrops
                    Group {
                        HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Backdrops")
                        
                        InsetGalleryView(movieGallery: movieGallery)
                    }
                    .padding(.horizontal, 10)
                    
                    // Posters
                    //                        Group {
                    //                            HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Posters")
                    //
                    //                            CoverImageView(movieGallery: movieGallery)
                    //                        }
                    //                        .padding(.horizontal)
                }
                
                Group {
                    
                    RatingView(rating: Int(vm.movie?.voteAverage ?? 0))
                        .cornerRadius(10)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                    
                    Text(vm.movie?.overview ?? "")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .padding()
                
                Group {
                    
                    HeadingView(headingImage: "menubar.dock.rectangle.badge.record", headingText: "Recommendations Movies")
                    
                    RecommendationsMoviesView(movies: vm.recommendationsMovies)
                        .environmentObject(self.vm)
                }
                
                Spacer()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
            .padding()
            .navigationBarTitle("\(vm.movie?.title ?? "")", displayMode: .inline)
        }
        .onAppear {
            self.vm.movieId = movieId
            self.vm.getMovieDetails(movieId: movieId)
            self.vm.getMovieGallery(movieId: movieId)
            self.vm.getRecommendationsMovieList(movieId: movieId)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieId: 27205)
    }
}
