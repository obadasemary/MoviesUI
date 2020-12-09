//
//  LoadingView.swift
//  MoviesOMDB
//
//  Created by Abdelrahman Mohamed on 6.10.2020.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - PROPERTIES
    
    @State private var isRoundedRectanglesLoading = false
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            Text("Loading")
                .font(.system(.body, design: .rounded))
                .bold()
                .offset(x: 0, y: -25)
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250, height: 3)
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.green, lineWidth: 3)
                .frame(width: 50, height: 3)
                .offset(x: isRoundedRectanglesLoading ? 110 : -110, y: 0)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isRoundedRectanglesLoading = true
                }
        }
    }
}

// MARK: - PREVIEW

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
