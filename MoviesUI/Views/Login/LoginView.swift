//
//  LoginView.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 15.12.2020.
//

import SwiftUI

struct LoginView: View, SwifyMessagebale {
    
    @ObservedObject var vm = LoginVM(repo: Injector.mainServiceRepo)
    //    @State private var tokenState = LoadingState<TokenResponse>.idle
    @State private var isPresented = false
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("Login")
                    .foregroundColor(.accentColor)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .padding()
                
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
                
                FormFieldView(
                    fieldKey: "Username",
                    fieldIcon: "person",
                    fieldValue:
                        Binding(
                            get: {
                                (self.vm.username ?? "")
                            }, set: { newValue in
                                self.vm.username = newValue
                            }
                        )
                    ,
                    isSecure: false
                )
                
                FormFieldView(
                    fieldKey: "Password",
                    fieldIcon: "lock",
                    fieldValue:
                        Binding(
                            get: {
                                (self.vm.password ?? "")
                            }, set: { newValue in
                                self.vm.password = newValue
                            }
                        )
                    ,
                    isSecure: true
                )
                
                Spacer(minLength: 100)
                
                Button(action: {
                    self.vm.login()
                }, label: {
                    Text("Login")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.primary)
                        .bold()
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(
                            Color.accentColor
                        )
                        .cornerRadius(12)
                        .padding()
                        .padding(.horizontal)
                })
                .fullScreenCover(isPresented: $isPresented, content: {
                    MainView()
                })
            }
            .onReceive(self.vm.$tokenState) { value in
                showSwiftMessage(state: value)
                if case .loaded(let model) = value {
                    self.vm.createSession()
                } else {
                    showSwiftMessage(state: value)
                }
            }
            .onReceive(self.vm.$createSessionState) { (value) in
                showSwiftMessage(state: value)
                if case .loaded(let model) = value {
                    self.isPresented.toggle()
                } else {
                    showSwiftMessage(state: value)
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    Color.accentColor,
                    lineWidth: 1
                )
        )
        .padding()
        .background(
            LinearGradient.blackOpacityGradient
            //                .padding(.top, 250)
        )
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            self.vm.createRequestToken()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension LinearGradient {
    
    static let blackOpacityGradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color.black.opacity(0.0),
                Color.black.opacity(0.95)
            ]
        ),
        startPoint: .top,
        endPoint: .bottom
    )
}
