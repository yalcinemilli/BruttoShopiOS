//
//  ContentView.swift
//  Bruttoshop
//
//  Created by Yalcin Emilli on 06.05.21.
//

import SwiftUI
import UIKit

struct ContentView: View {

    @StateObject var webViewStateModel: WebViewStateModel = WebViewStateModel()

    var body: some View {
        NavigationView {
            WebView(url: "https://bruttoshop.de",
                    tintColor: Color.white,
                    titleColor: Color.white,
                    hidesBackButton: true,
                    hidesReloadButton: true,
                    hidePopup: true,
                    title: "Bruttoshop")

        }
        .navigationViewStyle(StackNavigationViewStyle())
  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
