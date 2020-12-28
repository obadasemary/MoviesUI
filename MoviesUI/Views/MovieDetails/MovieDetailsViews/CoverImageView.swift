//
//  CoverImageView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 10.12.2020.
//

import SwiftUI

struct CoverImageView: View {
    
    // MARK: - PROPERTIES
    
    var movieGallery: MovieGallery
    
    // MARK: - BODY
    
    var body: some View {
        TabView {
            ForEach(movieGallery.posters ?? []) { poster in
                kfImageView(url: URLBuilder.imageUrl(path: poster.filePath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png") ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .cornerRadius(12)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct CoverImageView_Previews: PreviewProvider {
    
    static let movieGallery: MovieGallery = Bundle.main.decode("movieGalleryResponse.json")
    
    static var previews: some View {
        CoverImageView(movieGallery: movieGallery)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
