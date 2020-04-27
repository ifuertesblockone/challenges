//
//  ContentView.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("In order to Query the last 20 blocks please press \"Go\"")
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .padding(.horizontal, 15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
