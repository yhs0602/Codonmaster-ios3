//
//  RankingData.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/31.
//

import Foundation

struct RankingData : Hashable, Codable {
    var nickname: String
    var score: Int
    var timestamp: Double
}
