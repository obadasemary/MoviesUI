//
//  FormFieldView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 21.10.2020.
//

import SwiftUI

struct FormFieldView: View {
    
    var fieldKey = ""
    var fieldIcon = ""
    @Binding var fieldValue: String
    
    var isSecure = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image(systemName: fieldIcon)
                    .foregroundColor(.accentColor)
                
                if isSecure {
                    SecureField(fieldKey, text: $fieldValue)
                } else {
                    TextField(fieldKey, text: $fieldValue)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        Color.accentColor,
                        lineWidth: 1
                    )
            )
            .padding()
        }
    }
}

struct FormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FormFieldView(
            fieldKey: "Username",
            fieldIcon: "person",
            fieldValue: .constant("Obada.semary"),
            isSecure: false
        )
    }
}
