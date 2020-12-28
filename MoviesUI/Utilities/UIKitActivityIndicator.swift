//
//  UIKitActivityIndicator.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 9.12.2020.
//

import UIKit
import SwiftUI

struct UIKitActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style = .medium) {
        self._isAnimating = isAnimating
        self.style = style
    }
    
    init(state: Binding<Bool>, style: UIActivityIndicatorView.Style = .medium) {
        self._isAnimating = .constant(false)
        
        self.style = style
    }

    private let spinner: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))

    func makeUIView(context: UIViewRepresentableContext<UIKitActivityIndicator>) -> UIActivityIndicatorView {
        spinner.style = style
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<UIKitActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }

    func configure(_ indicator: (UIActivityIndicatorView) -> Void) -> some View {
        indicator(spinner)
        return self
    }
}

struct UIKitActivityStateIndicator<T: Codable>: UIViewRepresentable {

    @Binding var state: LoadingState<T>
    let style: UIActivityIndicatorView.Style
    
    init(state: Binding<LoadingState<T>>, style: UIActivityIndicatorView.Style = .medium) {
        self._state = state
        self.style = style
    }

    private let spinner: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        spinner.style = style
        return spinner
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        switch state {
        case .idle:
            uiView.stopAnimating()
        case .loading:
            uiView.startAnimating()
        case .failed(_):
            uiView.stopAnimating()
        case .loaded(_):
            uiView.stopAnimating()
        }
    }

    func configure(_ indicator: (UIActivityIndicatorView) -> Void) -> some View {
        indicator(spinner)
        return self
    }
}
