//
//  ContentView.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import SwiftUI


let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    return dateFormatter
}()

struct HomeView: View {
    private var playImageIcon = Image(systemName: "play.circle")
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 10){
                Text("In order to Query the EOS Blockchain press \"play button\"")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 15)
                    .foregroundColor(.red)
                NavigationLink(destination: ListView()){
                    playImageIcon.resizable().frame(width: 100,height: 100)
                }
                .foregroundColor(.blue)
                .padding(.top, 20)
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



