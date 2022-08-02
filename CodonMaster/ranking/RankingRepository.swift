//
//  RankingRepository.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/08/02.
//

import Foundation
import FirebaseDatabase

class RankingDB {
    static let shared = RankingDB()

    var ref: DatabaseReference!

    private init() {
        ref = Database.database(url: "https://codonmaster-5018a-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    }

    func addRankingInfo(_ data: RankingData) {
        ref.child("ranking").childByAutoId().setValue(data)
    }

    func getRankings(completionHandler: @escaping ([RankingData]) -> Void) {
        ref.child("ranking").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print(snapshot?.value ?? "")

            let rankings = (snapshot?.value as? [Dictionary<String, Any>])?.map { value in
                RankingData(
                    name: value["nickname"] as? String ?? "error",
                    score: value["score"] as? Int ?? -1,
                    timestamp: value["timestamp"] as? Double ?? 0
                )
            } ?? []
            completionHandler(rankings)
        }
    }
}
