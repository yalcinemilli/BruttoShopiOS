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
public struct WebView: View {
    
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
    //@StateObject var statusBarConfigurator = StatusBarConfigurator()

    public init(url: String,
         tintColor: Color = .blue,
         titleColor: Color = .white,
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

        let appearance = UIToolbarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = self.farbe
        UIToolbar.appearance().standardAppearance = appearance;
        
        if #available(iOS 15.0, *) {
            UIToolbar.appearance().scrollEdgeAppearance = UIToolbar.appearance().standardAppearance
        }
  
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
        
      //  LoadingView(isShowing: .constant(webViewStateModel.loading)) {

        if !self.hidePopup {
            ZStack(alignment: .top) {
                        Rectangle()
                            .foregroundColor(Color("bruttoColor"))
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
                
            PopUp(isShowing: self.$show) {
                WebPresenterView(url: URL.init(string: url)!, webViewStateModel: webViewStateModel, title: title, onNavigationAction: onNavigationAction, allowedHosts: allowedHosts, forbiddenHosts: forbiddenHosts, credential: credential)
                
            }
            .navigationBarBackButtonHidden(true)
            //.navigationBarTitle(Text(webViewStateModel.pageTitle), displayMode: .inline)
                
                    .navigationBarHidden(true)
            //.edgesIgnoringSafeArea(.all)
            .toolbar {
              
                
                ToolbarItem(placement: .bottomBar) {
                    HStack() {
                        Button {
                            if self.webViewStateModel.canGoBack {
                                self.webViewStateModel.goBack.toggle()
                            }
                        } label: {
                            VStack{
                            goBackImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            Text("Zurück")
                                .font(.caption)
                            }
                        }
                  Spacer()
                        Button {
                            if self.webViewStateModel.canGoForward {
                                self.webViewStateModel.goForward.toggle()
                            }
                        } label: {
                            VStack {
                            goForwardImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                Text("Vor")
                                    .font(.caption)
                                }
                        }
                        Button {
                            if !homeButton {
                            self.webViewStateModel.home.toggle()
                            }
                        } label: {
                            VStack {
                            goHomeImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                Text("Startseite")
                                    .font(.caption)
                                }
                        }
                        
                        Button {
                            if !accountButton {
                                self.webViewStateModel.account.toggle()
                            }
                        } label: {
                            VStack {
                            goAccountImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                Text("Mein Konto")
                                    .font(.caption)
                                }
                            }
                        Button {
                            if !popupButton {
                                self.show.toggle()
                            }
                        } label: {
                            VStack {
                            goPopupImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                             Text("Angebote")
                                .font(.caption)
                            }
                            }
                    }
                    .accentColor(tintColor)
                    .padding([.top], 20)
                    
                    
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
             //.edgesIgnoringSafeArea(.all)
            }
            
        } else {
            ZStack(alignment: .top) {
                        Rectangle()
                            .foregroundColor(Color("bruttoColor"))
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
            WebPresenterView(url: URL.init(string: url)!, webViewStateModel: webViewStateModel, title: title, onNavigationAction: onNavigationAction, allowedHosts: allowedHosts, forbiddenHosts: forbiddenHosts, credential: credential)
                
            .navigationBarBackButtonHidden(true)
            //.navigationBarTitle(Text(webViewStateModel.pageTitle), displayMode: .inline)
                
                    .navigationBarHidden(true)
            //.edgesIgnoringSafeArea(.bottom)
                    
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                        Spacer(minLength: 20)
                        Button {
                            if self.webViewStateModel.canGoBack {
                                self.webViewStateModel.goBack.toggle()
                            }
                        } label: {
                            if self.webViewStateModel.canGoBack
                            {VStack{
                            goBackImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                            Text("Zurück")
                                .font(.caption)
                                .foregroundColor(.white)
                            }
                            .padding([.bottom, .top], 15)
                            } else {
                                VStack{
                                goBackImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.gray)
                                Text("Zurück")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                }
                                .padding([.bottom, .top], 15)
                            }
                        }
                        //Spacer(minLength: 20)
                        Spacer()
                        Button {
                            if self.webViewStateModel.canGoForward {
                                self.webViewStateModel.goForward.toggle()
                            }
                        } label: {
                            if self.webViewStateModel.canGoForward
                            {VStack {
                            goForwardImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                Text("Vorwärts")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                }
                            .padding([.bottom, .top], 15)
                            } else {
                                VStack {
                                goForwardImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.gray)
                                    Text("Vorwärts")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    }
                                .padding([.bottom, .top], 15)
                            }
                        
                    }
                       // Spacer(minLength: 20)
                       Spacer()

                        Button {
                            if !homeButton {
                            self.webViewStateModel.home.toggle()
                            }
                        } label: {
                            VStack {
                            goHomeImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                Text("Startseite")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                }
                            .padding([.bottom, .top], 15)
                        }
                        //Spacer(minLength: 20)
                        Spacer()
                        Button {
                            if !accountButton {
                                self.webViewStateModel.account.toggle()
                            }
                        } label: {
                            VStack {
                            goAccountImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                Text("Mein Konto")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                }
                            .padding([.bottom, .top], 15)
                            }
                        Spacer(minLength: 20)
                    
                    
                        
                }
                
                
            }
            }
            
            }
        
        
    }
        
}

