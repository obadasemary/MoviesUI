//
//  AddToListView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 17.12.2020.
//

import SwiftUI

struct AddToListView: View, SwifyMessagebale {
    
    @EnvironmentObject var vm: AddToListVM
    var movieId: Int
    var movieName: String
    var doWeNeedSpacer: Bool
    
    var body: some View {
        HStack {
            
            if doWeNeedSpacer {
                Spacer()
            }
            
            Group {
                
                Button(action: {
                    self.vm.addMovieToFavoritelist(movieId: movieId)
                }, label: {
                    Image(systemName: "heart.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                })
                
                Button(action: {
                    self.vm.addMovieToWatchList(movieId: movieId)
                }, label: {
                    Image(systemName: "bookmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                })
            }
        }
        .onReceive(self.vm.$addToFavoriteListState, perform: { value in
            showSwiftMessage(state: value)
            if case .loaded(let model) = value {
                if model.statusCode == 1 {

                    showSwiftMessage(state: value, showMessage: "\(movieName) Added successfully to your Favorite List")
                } else {
                    showSwiftMessage(state: value, showMessage: model.statusMessage)
                }
            } else {
                showSwiftMessage(state: value)
            }
        })
        .onReceive(self.vm.$addToWatchListState, perform: { value in
            showSwiftMessage(state: value)
            if case .loaded(let model) = value {
                if model.statusCode == 1 {
                    showSwiftMessage(state: value, showMessage: "\(movieName) Added successfully to your Watch List")
                } else {
                    showSwiftMessage(state: value, showMessage: model.statusMessage)
                }
            } else {
                showSwiftMessage(state: value)
            }
        })
    }
}

struct AddToListView_Previews: PreviewProvider {
    static var previews: some View {
        AddToListView(movieId: 155, movieName: "The Dark Knight (2008)", doWeNeedSpacer: true)
    }
}
