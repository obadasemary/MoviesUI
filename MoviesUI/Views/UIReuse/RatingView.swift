//
//  RatingView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 8.12.2020.
//

import SwiftUI

struct RatingView: View {
    
    var rating: Int?
    
    var body: some View {
        HStack {
            ForEach(1...10, id: \.self) { index in
                Image(systemName: self.starType(index: index))
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    func starType(index: Int) -> String {
        
        guard let rating = rating else {
            return "star"
        }
        
        return index <= rating ? "star.fill" : "star"
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 7)
            .cornerRadius(10)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
            )
            .padding([.all])
        //            .previewLayout(.sizeThatFits)
        //            .padding()
    }
}
