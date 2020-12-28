//
//  KFImage.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 8.12.2020.
//

import SwiftUI
import KingfisherSwiftUI

@ViewBuilder
func kfImageView(url: String, renderingMode: SwiftUI.Image.TemplateRenderingMode = .original) -> KFImage {
    
    KFImage(
        URL(string: url),
        options: [
            .transition(.fade(0.2)),
        ]
    )
    .renderingMode(renderingMode)
    .onSuccess { r in
        //print("success: \(r)")
    }
    .onFailure { e in
        //print("failure: \(e)")
    }
    .placeholder {
        Image(systemName: "arrow.2.circlepath.circle")
            .font(.largeTitle)
            .opacity(0.3)
    }
}
