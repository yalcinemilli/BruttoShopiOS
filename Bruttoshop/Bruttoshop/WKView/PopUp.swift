//
//  PopUp.swift
//  Bruttoshop
//
//  Created by Yalcin Emilli on 12.05.21.
//

import SwiftUI


public struct PopUp<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    @StateObject var webViewStateModel: WebViewStateModel = WebViewStateModel()
    public var body: some View {
        
        ZStack {
            
            self.content()
                .disabled(self.isShowing)
                .blur(radius: self.isShowing ? 3 : 0)

            
            VStack {
            WebView(url: "https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-images-using-image-views",
                tintColor: Color.white,
                titleColor: Color.white,
                hidesBackButton: true,
                hidesReloadButton: true,
                hidePopup: true,
                title: "Bruttoshop")
             .background(Color.black)
                    
                    .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height - 300)
                
                Button(action: {
                    withAnimation {
                        self.isShowing.toggle()
                    }
                    
                }) {
                    Image(systemName: "xmark").resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.black)
                        .padding(20)
                }
                .background(Color.white)
                .clipShape(Circle())
                .padding(.top, 25)
            }
            .opacity(self.isShowing ? 1 : 0)

        }
        
    
    }
}

