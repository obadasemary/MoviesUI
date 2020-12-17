//
//  SwifttyMessagable.swift
//  MoviesUI
//
//  Created by Abdelrahman Mohamed on 11/14/20.
//

import Foundation
import SwiftMessages
import SwiftUI

protocol SwifyMessagebale where Self: View {
    func showStatusBarMessage(body:String, isError: Bool)
}

#if canImport(UIKit)
extension SwifyMessagebale {
    func showStatusBarMessage(body:String, isError: Bool = true) {
        let warning = MessageView.viewFromNib(layout: .cardView)
//        warning.bodyLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 20))
        warning.bodyLabel?.textAlignment = .right
        warning.configureTheme((isError ? Theme.error : Theme.success))
        
//        let backgroundColor = Color.white
//        let foregroundColor = Color.accentColor
        
        warning.configureDropShadow()
        warning.configureContent(title: "", body: body)
        warning.button?.isHidden = true
        
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}
#endif

extension View where Self: SwifyMessagebale {
    func showSwiftMessage<T: Codable>(state: LoadingState<T>, showMessage: String? = nil) {
        if let message = showMessage {
            showStatusBarMessage(body: message, isError: false)
        }
        else if case .failed(value: let value) = state {
            showStatusBarMessage(body: value.message)
        }
    }
}
