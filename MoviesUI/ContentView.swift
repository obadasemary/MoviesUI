//
//  ContentView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 16.11.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = MovieListVM(repo: Injector.mainServiceRepo)
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                self.vm.load()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
