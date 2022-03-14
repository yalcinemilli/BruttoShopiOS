//
//  WebView.swift
//
//
//  Created by Alex Nagy on 09.12.2020.
//

import SwiftUI
import UIKit
import WebKit

@available(iOS 14.0, *)
public struct WebView2: View {
    
    let url: String
    let tintColor: Color
    let backText: Text
    let hidesBackButton: Bool
    let hidesReloadButton: Bool
    let hidePopup: Bool
    let hideBottombar: Bool
    let homeButton: Bool
    let popupButton: Bool
    let accountButton: Bool
    
    let reloadImage: Image
    let goForwardImage: Image
    let goBackImage: Image
    let goHomeImage: Image
    let goPopupImage: Image
    let goAccountImage: Image
    let title: String?
    var allowedHosts: [String]?
    var forbiddenHosts: [String]?
    var credential: URLCredential?
    var onNavigationAction: ((_ navigationAction: WebPresenterView.NavigationAction) -> Void)?
    let farbe: UIColor = UIColor(Color("bruttoColor"))
    
/*    public init(url: String,
         tintColor: Color = .blue,
         titleColor: Color = .primary,
         backText: Text = Text("Back"),
         hidesBackButton: Bool = false,
         reloadImage: Image = Image(systemName: "gobackward"),
         goForwardImage: Image = Image(systemName: "chevron.forward"),
         goBackImage: Image = Image(systemName: "chevron.backward"),
         title: String? = nil,
         allowedHosts: [String]? = nil,
         forbiddenHosts: [String]? = nil,
         credential: URLCredential? = nil,
         onNavigationAction: ((_ navigationAction: WebPresenterView.NavigationAction) -> Void)? = nil) {
        self.url = url
        self.tintColor = tintColor
        self.backText = backText
        self.hidesBackButton = hidesBackButton
        self.reloadImage = reloadImage
        self.goForwardImage = goForwardImage
        self.goBackImage = goBackImage
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(titleColor)]
  */
    public init(url: String,
         tintColor: Color = .blue,
         titleColor: Color = .primary,
         backText: Text = Text("Back"),
         hidesBackButton: Bool = false,
         hidesReloadButton: Bool = false,
         hidePopup: Bool = false,
         hideBottombar: Bool = false,
         homeButton: Bool = false,
        cartButton: Bool = false,
         accountButton: Bool = false,
         reloadImage: Image = Image(systemName: "gobackward"),
         goForwardImage: Image = Image(systemName: "chevron.forward"),
         goBackImage: Image = Image(systemName: "chevron.backward"),
         goHomeImage: Image = Image(systemName: "house"),
         goPopupImage:Image = Image(systemName: "rectangle.3.offgrid.bubble.left"),
         goAccountImage: Image = Image(systemName: "person.crop.circle"),
         title: String? = nil,
         allowedHosts: [String]? = nil,
         forbiddenHosts: [String]? = nil,
         credential: URLCredential? = nil,
         onNavigationAction: ((_ navigationAction: WebPresenterView.NavigationAction) -> Void)? = nil) {
        self.url = url
        self.tintColor = tintColor
        self.backText = backText
        self.hidesBackButton = hidesBackButton
        self.hidesReloadButton = hidesReloadButton
        self.hidePopup = hidePopup
        self.hideBottombar = hideBottombar
        self.homeButton = homeButton
        self.popupButton = cartButton
        self.accountButton = accountButton
        self.reloadImage = reloadImage
        self.goForwardImage = goForwardImage
        self.goBackImage = goBackImage
        self.goHomeImage = goHomeImage
        self.goPopupImage = goPopupImage
        self.goAccountImage = goAccountImage
        
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(titleColor)]
        UINavigationBar.appearance().barTintColor = self.farbe
        UIToolbar.appearance().barTintColor = self.farbe
        UIToolbar.appearance().tintColor = self.farbe

        self.title = title
        
        self.allowedHosts = allowedHosts
        self.forbiddenHosts = forbiddenHosts
        self.credential = credential
        self.onNavigationAction = onNavigationAction
           
    }
    
    @StateObject var webViewStateModel: WebViewStateModel = WebViewStateModel()
    @Environment(\.presentationMode) var presentationMode
    @State var show = false
    
    public var body: some View {
        
        /*LoadingView(isShowing: .constant(webViewStateModel.loading)) {
            WebPresenterView(url: URL.init(string: url)!, webViewStateModel: webViewStateModel, title: title, onNavigationAction: onNavigationAction, allowedHosts: allowedHosts, forbiddenHosts: forbiddenHosts, credential: credential)
        }*/
        ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(Color("bruttoColor"))
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 0)
            
        //PopUp(isShowing: self.$show) {
            WebPresenterView(url: URL.init(string: url)!, webViewStateModel: webViewStateModel, title: title, onNavigationAction: onNavigationAction, allowedHosts: allowedHosts, forbiddenHosts: forbiddenHosts, credential: credential)
      //  }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
        
        .toolbar {
         
            
            ToolbarItem(placement: .bottomBar) {
                HStack(spacing: 16) {
                    Button {
                        if self.webViewStateModel.canGoBack {
                            self.webViewStateModel.goBack.toggle()
                        }
                    } label: {
                        goBackImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    
                    Button {
                        if self.webViewStateModel.canGoForward {
                            self.webViewStateModel.goForward.toggle()
                        }
                    } label: {
                        goForwardImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                }
                .accentColor(tintColor)
            }
        }
        .navigationBarItems(
            leading:
                Button {
                    if !hidesBackButton {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    if !hidesBackButton {
                        backText
                    } else {
                        Spacer()
                    }
                }
                .accentColor(tintColor)
            , trailing:
                Button {
                    if !hidesReloadButton {
                    self.webViewStateModel.reload.toggle()
                    }
                } label: {
                    if !hidesReloadButton {
                    reloadImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    } else {
                        Spacer()
                    }
                }
                .accentColor(tintColor)
        )
        
    }
    }
}
