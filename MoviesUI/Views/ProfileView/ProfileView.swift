//
//  ProfileView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm = ProfileVM(repo: Injector.mainServiceRepo)
    
    var body: some View {
        ScrollView {
            VStack {
                
                kfImageView(url: URLBuilder.imageUrl(path: vm.profileResponse?.avatar?.tmdb?.avatarPath ?? "wwemzKWzjKYJFfCeiB57q3r4Bcm.png") ?? "")
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
                
                Group {
                    
                    VStack(alignment: .center) {
                        Text(vm.profileResponse?.name ?? "")
                            .foregroundColor(.primary)
                            .font(.system(.title, design: .rounded))
                            .bold()
                        Text(vm.profileResponse?.username ?? "")
                            .foregroundColor(.secondary)
                            .font(.system(.title3, design: .rounded))
                    }
                    .layoutPriority(100)
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Divider()
                    .frame(height: 1)
                    .background(Color.accentColor)
                    .padding(.horizontal, 40)
            }
        }
        .onAppear {
            self.vm.getAccountDetails()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
