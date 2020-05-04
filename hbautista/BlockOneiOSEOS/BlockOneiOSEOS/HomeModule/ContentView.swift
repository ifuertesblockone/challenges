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
        VStack(alignment: .center, spacing:15){
            Text("In order to Query the last 20 blocks please press \"play button\"")
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(.horizontal, 15)
                .foregroundColor(.red)
            Button(action: {
                showList()
            }){
                playImageIcon.resizable().frame(width: 100,height: 100)
            }
            .foregroundColor(.blue)
            .padding(.top, 50)
            
        
        }.padding(15)
        
        
        
        
        
    }
}

func showList() {
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
