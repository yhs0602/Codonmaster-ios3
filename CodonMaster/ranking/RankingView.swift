//
//  RankingView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/21.
//

import Foundation
import SwiftUI

struct RankingView: View {
    @StateObject var rankingViewModel = RankingViewModel()
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(rankingViewModel.rankings, id: \.self) { ranking in
                    HStack {
                        Text(ranking.nickname)
                        Text(String(ranking.score))
                        Text(Date(timeIntervalSince1970: ranking.timestamp).description)
                    }
                }
            }
        }
        .onAppear {
            rankingViewModel.fetchRanking()
        }
    }
}
