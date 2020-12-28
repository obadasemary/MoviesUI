//
//  AsyncContentView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 9.12.2020.
//

import SwiftUI
import Combine

enum LoadingState<Value: Codable>: Equatable {
    case idle
    case loading
    case failed(APIError)
    case loaded(Value)
}

func ==<T: Codable>(lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
    if case .loading = lhs, case .loading = rhs {
        return true
    }
    return false
}

protocol LoadableObject: ObservableObject {
    associatedtype Output: Codable
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
    
    init(source: Source, @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            UIKitActivityIndicator(isAnimating: .constant(true), style: .large)
                .configure {
                    $0.color = UIColor(Color.accentColor)
                }.onAppear(perform: source.load)
        case .failed(let error):
            Text(error.localizedDescription)
            //ErrorView(error: error, retryHandler: source.load)
        case .loaded(let output):
            content(output)
        }
    }
}
