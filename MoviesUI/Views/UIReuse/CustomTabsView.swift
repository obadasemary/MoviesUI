//
//  CustomTabsView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 21.10.2020.
//

import SwiftUI

struct CustomTabsView: View {
    
    @Binding var currentTab: CustomTab
    var tabs: [CustomTab]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(tabs, id: \.self) { tab in
                    Button(action: {
                        currentTab = tab
                    }, label: {
                        Text(tab.rawValue)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(tab == currentTab ? Color.black : Color.white)
                            .frame(width: 100, height: 50, alignment: .center)
//                            .padding()
                            .background(
                                (tab == currentTab ? Color.accentColor : Color.black)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.1), radius: 10, x: -5, y: -5)
                            )
                    })
                }
            }
            .padding()
        }
    }
}

struct ProfileTabsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabsView(currentTab: Binding<CustomTab>.constant(.topRated), tabs: [.topRated, .upcoming, .nowPlaying, .popular])
    }
}
