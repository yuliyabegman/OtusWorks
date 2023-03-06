//
//  BrowserScreen.swift
//  Homework001
//
//  Created by Юлия Бегман on 04.03.2023.
//

import SwiftUI
import WebKit

struct BrowserScreen: View {
    
    let link: String
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            if let url = URL(string: link) {
                GeometryReader { geo in
                    WebView(request: URLRequest(url: url))
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            } else {
                Spacer()
                Text("Нет данных для отображения")
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
}

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}
