//
//  ListModule.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView {
            BlockChainView()
            .navigationBarTitle("")
            .navigationBarHidden(true)
            BlockDetailView()
        }
        .navigationBarTitle("Last EOS Blocks", displayMode: .inline)
    }
}

struct BlockChainView: View {
    @ObservedObject var fetcher = ListPresenter()
    
    var body: some View {
        List(fetcher.blocks) { block in
            NavigationLink(
                destination: BlockDetailView(block: block, jsonRawDict: self.fetcher.jsonRawDict)
            ) {
                Text("\(block.blockNum!)")
                Text("\(block.id!)")
                .font(.system(size: 11))
                .foregroundColor(Color.gray)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
