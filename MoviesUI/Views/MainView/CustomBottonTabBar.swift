//
//  CustomBottonTabBar.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 23.11.2020.
//

import SwiftUI

struct CustomBottonTabBar: View {
    
    @Binding var currentTab: CustomBottonTabBarTabs
    
    var tabs: [CustomBottonTabBarTabs]
    var darkYelloColor: Color = Color(red: 255 / 255, green: 175 / 255, blue: 2 / 255)
    
    var body: some View {
        HStack {
            
            ForEach(tabs, id: \.self) { tab in
                
                Button(action: {
                    currentTab = tab
                }, label: {
                    Image(systemName: tab.rawValue)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 26, height: 26, alignment: .center)
                        .padding()
                        .background(
                            currentTab == tab ? darkYelloColor : Color.pink
                        )
                        .frame(width: 46, height: 46, alignment: .center)
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity)
                })
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 72, alignment: .center)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(
            color: Color.black.opacity(0.21),
            radius: 34, x: 0, y: 7
        )
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomBottonTabBar(currentTab: Binding<CustomBottonTabBarTabs>.constant(.movies), tabs: [.movies, .heart, .person])
    }
}


