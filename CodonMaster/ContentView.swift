//
//  ContentView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack (spacing: 30) {
                Text("코돈 마스터")
                NavigationLink {
                    GameView()
                } label: {
                    Label("Game Start", systemImage: "play")
                }

                //                NavigationLink {
                //                    RankingView()
                //                } label: {
                //                    Label("Ranking", systemImage: "crown")
                //                }
                NavigationLink {
                    AnnounceView()
                } label: {
                    Label("Announcement", systemImage: "speaker")
                }

                NavigationLink {
                    SettingView()
                } label: {
                    Label("Setting", systemImage: "gearshape")
                }

            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
