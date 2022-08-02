//
//  RankingViewModel.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/08/02.
//

import Foundation

class RankingViewModel: ObservableObject {
    @Published var rankings: [RankingData] = []

    func fetchRanking() {
        print("Fetch ranking")
        RankingDB.shared.getRankings { rankings in
            self.rankings = rankings
            print("Got rankings: \(rankings)")
        }
    }
}
