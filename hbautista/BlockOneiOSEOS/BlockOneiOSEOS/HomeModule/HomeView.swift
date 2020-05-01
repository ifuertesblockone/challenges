//
//  ContentView.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    private var playImageIcon = Image(systemName: "play.circle")
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Text("In order to Query the EOS ")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(.red)
                Text("Blockchain press \n 'Play Button'")
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .foregroundColor(.red)
                NavigationLink(destination: ListView()){
                    playImageIcon.resizable().frame(width: 100,height: 100)
                }
                .foregroundColor(.blue)
                .padding(.top, 20)
                .id("toList")
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
