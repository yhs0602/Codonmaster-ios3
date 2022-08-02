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
        ref.child("ranking").childByAutoId().setValue(data.dictionary)
    }
    
    func getRankings(completionHandler: @escaping ([RankingData]) -> Void) {
        ref.child("ranking").queryOrdered(byChild: "score").getData { error, snapshot in //
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print(snapshot?.value ?? "")
            
            if let rankings = (snapshot?.value as? Dictionary<String, Dictionary<String, Any>>)?.values.map({ value in
                RankingData(
                    nickname: value["nickname"] as? String ?? "error",
                    score: value["score"] as? Int ?? -1,
                    timestamp: value["timestamp"] as? Double ?? 0
                )
            }) {
                completionHandler(rankings)
            } else {
                print("error")
            }
        }
    }
}
