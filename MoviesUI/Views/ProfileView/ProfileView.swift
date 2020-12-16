//
//  ProfileView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                
                Image("avengers1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                Color.accentColor,
                                lineWidth: 1
                            )
                    )
                    .padding()
                
                Text("Login")
                    .foregroundColor(.primary)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .padding()
                
                Text("Login")
                    .foregroundColor(.secondary)
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .padding()
                
                Spacer()
            }
        }
        .onAppear {
            AuthorizationDataManager.shared.getAuthorizationSession()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
