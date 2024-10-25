//
//  ContentView.swift
//  CocktailApp
//
//  Created by Ensar on 25.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            LaunchScreenViewControllerRepresentable() // UIKit animasyonunu SwiftUI içinde kullanıyoruz
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

