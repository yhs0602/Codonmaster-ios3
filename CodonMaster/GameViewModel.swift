//
//  GameViewModel.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/27.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var acids: [Acid] = [
        Acid(age: 0.5, x: 0.3, kind: .Phe),
        Acid(age: 0, x: 0.3, kind: .Leu),
        Acid(age: 0.8, x: 0.8, kind: .Met),
        Acid(age: 0.6, x: 0.9, kind: .Gly),
        Acid(age: 1, x: 0.9, kind: .His),
        Acid(age: 1, x: 1, kind: .Gln),
    ]

    let acidPublisher: AnyPublisher<Acid, Never>
    var acidPublishCancellable: AnyCancellable? = nil
    var gameLoopCancellable: AnyCancellable? = nil
    init() {
        acidPublisher = CodonMaster.acidPublisher()
        acidPublishCancellable = acidPublisher
            .receive(on: RunLoop.main)
            .sink { acid in
            self.acids.append(acid)
            print("Generated acid \(acid.kind)")
        }
        gameLoopCancellable = Timer.publish(every: 0.5, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { time in
            for index in self.acids.indices {
                self.acids[index].age += 0.01
            }
        }
    }

    func invalidate() {
        acidPublishCancellable?.cancel()
        acidPublishCancellable = nil
        gameLoopCancellable?.cancel()
        gameLoopCancellable = nil
        print("[<<] invalidated")
    }
}

enum AcidKind: CaseIterable {
    case Phe, Leu, Ile, Met, Val, Ser, Pro, Thr, Ala, Tyr, End, His, Gln, Asn, Lys, Asp, Glu, Cys, Trp, Arg, Gly
}

struct Acid: Hashable {
    var age: Float // 0..1
    let x: Float
    let kind: AcidKind
}
