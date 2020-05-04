//
//  BlockDetailView.swift
//  BlockOneiOSEOS
//
//  Created by Henry Bautista on 27/04/20.
//  Copyright © 2020 Globant. All rights reserved.
//

import SwiftUI

struct BlockDetailView: View {
    var block: Block?
    var jsonRawDict: [String: String]?
    private let jsonImageIcon = Image(systemName: "doc.text.magnifyingglass")
    private let closeIcon = Image(systemName: "xmark.circle.fill")
    @State var isPresented = false

    var body: some View {
        ZStack {
             NavigationView {
                VStack(alignment: .center, spacing: 30){
                    if block != nil {
                        VStack(alignment: .center, spacing: 5){
                            Text("Id")
                                .font(.system(size: 14))
                                .foregroundColor(Color.blue)
                                .bold()
                                .padding(.horizontal, 30)
                            Text("\(block!.id!)")
                                .font(.system(size: 11))
                                .foregroundColor(Color.blue)
                                .bold()
                                .lineLimit(nil)
                                .padding(.horizontal, 30)
                        }
                        Text("Producer: \(block!.producer!)")
                            .font(.system(size: 12))
                            .foregroundColor(Color.red)
                            .padding(.horizontal, 30)
                        Text("Transactions count: \(block!.transactions!.count)")
                            .font(.system(size: 14))
                            .foregroundColor(Color.green)
                            .padding(.horizontal, 30)
                        VStack(alignment: .center, spacing: 5){
                            Text("Producer_signature")
                                .font(.system(size: 12))
                                .foregroundColor(Color.green)
                                .padding(.horizontal, 30)
                            Text("\(block!.producerSignature!)")
                                .font(.system(size: 10))
                                .foregroundColor(Color.green)
                                .lineLimit(nil)
                                .padding(.horizontal, 30)
                        }
                        VStack(alignment: .center, spacing: 10){
                            Text("press the following button \n to see raw Json Contents")
                            .font(.system(size: 12))
                            .foregroundColor(Color.blue)
                            .padding(.horizontal, 30)
                            .lineLimit(nil)
                            Button(action: {
                                withAnimation {
                                    self.isPresented.toggle()
                                }
                            })
                            {
                                jsonImageIcon.resizable().frame(width: 60,height: 60)
                            }
                        }.padding(.vertical,40)
                        
                    } else {
                        Text("Block details temporary unavailable")
                    }
                }
            }.navigationBarTitle("Block Summary", displayMode: .inline)
            ZStack{
                Spacer()
                HStack{
                    Spacer()
                    VStack {
                        HStack{
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    self.isPresented.toggle()
                                }
                            })
                            {
                                closeIcon.resizable().frame(width: 30,height: 30).foregroundColor(.white)
                            }.padding(.top, 150)
                        }
                    Spacer()
                    }
                    Spacer()
                }
                ScrollView {
                    Text("\(jsonRawDict![block!.id!]!)")
                    .font(.system(size: 7))
                    .foregroundColor(Color.yellow)
                    .padding(.horizontal,15)
                    .lineLimit(nil)
                }.padding(.top,180)
            }.background(Color.gray)
                .edgesIgnoringSafeArea(.all)
                .offset(x: 0, y: self.isPresented ? 0: UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.frame.height ?? 0)

        }
    }
}

struct BlockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BlockDetailView()
    }
}
