//
//  ContentView.swift
//  calculator
//
//  Created by Arunangshu Das on 25/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3),.yellow.opacity(0.4),]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
                KeyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
