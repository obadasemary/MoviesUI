//
//  WatchListView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import SwiftUI

struct WatchListView: View {
    
    @ObservedObject var vm = WatchListVM(repo: Injector.mainServiceRepo)
    @State var refresh = Refresh(started: false, released: false)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    Text("WatchList")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
    
                    Spacer()
                }
                .padding()
                .background(Color.black.ignoresSafeArea(.all, edges: .top))
    
                Divider()
                
                ScrollView {
                    
                    GeometryReader { reader -> AnyView in
                        
                        DispatchQueue.main.async {
                            
                            if refresh.startOffset == 0 {
                                refresh.startOffset = reader.frame(in: .global).minY
                            }
                            
                            refresh.offset = reader.frame(in: .global).minY
                            
                            if refresh.offset - refresh.startOffset > 80 && !refresh.started {
                                
                                refresh.started = true
                            }
                            
                            if refresh.startOffset == refresh.offset && refresh.started && !refresh.released {
                                
                                withAnimation(Animation.linear) {
                                    
                                    refresh.released = true
                                }
                                
                                updateData()
                            }
                            
                            if refresh.startOffset == refresh.offset && refresh.started && refresh.released && refresh.invalid {
                                
                                refresh.invalid = false
                                updateData()
                            }
                        }
                        
                        return AnyView(Color.black.frame(width: 0, height: 0))
                    }
                    .frame(width: 0, height: 0)
                    
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        
                        if refresh.started && refresh.released {
                            
                            ProgressView()
                                .offset(y: -35)
                        } else {
                            
                            Image(systemName: "arrow.down")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: refresh.started ? 180 : 0))
                                .offset(y: -25)
                                .animation(.easeIn)
                        }
                        
                        
                        LazyVStack {
                            ForEach(vm.movies, id: \.self) { movie in
                                NavigationLink(destination: MovieDetailsView(movieId: movie.id ?? 27205)) {
                                    MovieView(movie: movie)
                                        .onAppear {
                                            self.vm.loadMoreContentIfNeeded(currentItem: movie)
                                        }
                                }
                            }
                        }
                    }
                    .offset(y: refresh.released ? 40 : -10)
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            self.vm.getMovieWatchlist()
        }
    }
    
    func updateData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.linear) {
                
                if refresh.startOffset == refresh.offset {
                    
                    self.vm.moviesPage = 1
                    self.vm.moviesIsLoadingPage = false
                    self.vm.moviesCanLoadMorePages = true
                    self.vm.movies = []
                    
                    self.vm.getMovieWatchlist()
                    
                    refresh.released = false
                    refresh.started = false
                } else {
                    
                    refresh.invalid = true
                }
            }
        }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
