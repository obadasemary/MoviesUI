//
//  ActivityIndicator.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 28.10.2020.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color = UIColor.white

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.color = color
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
