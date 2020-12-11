//
//  InsetGalleryView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 10.12.2020.
//

import SwiftUI

struct InsetGalleryView: View {
    
    var movieGallery: MovieGallery
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 15) {
                ForEach(movieGallery.backdrops ?? [], id: \.self) { backdrop in
                    kfImageView(url: URLBuilder.imageUrl(path: backdrop.filePath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png") ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                }
            }
        }
    }
}

struct InsetGalleryView_Previews: PreviewProvider {
    
    static let movieGallery: MovieGallery = Bundle.main.decode("movieGalleryResponse.json")
    
    static var previews: some View {
        InsetGalleryView(movieGallery: movieGallery)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
