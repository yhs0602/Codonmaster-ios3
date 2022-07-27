//
//  GameViewModel.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/27.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var acids: [Acid] = [
        Acid(age: 0.5, x: 0.3, kind: .Phe),
        Acid(age: 0, x: 0.3, kind: .Leu),
        Acid(age: 0.8, x: 0.8, kind: .Met),
        Acid(age: 0.8, x: 0.9, kind: .Gly),
    ]
}

enum AcidKind {
    case Phe, Leu, Ile, Met, Val, Ser, Pro, Thr, Ala, Tyr, End, His, Gln, Asn, Lys, Asp, Glu, Cys, Trp, Arg, Gly
}

struct Acid: Hashable {
    var age: Float // 0..1
    let x: Float
    let kind: AcidKind
}
