//
//  GameViewModel.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/27.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var acids: [Acid] = []
    @Published var combiningAcid: [Base] = []

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
        gameLoopCancellable = Timer.publish(every: 0.025, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { time in
            for index in self.acids.indices {
                self.acids[index].age += 0.002
            }
            self.acids = self.acids.filter { acid in
                acid.age <= 1
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

    func onClickBase(what: String) {
        switch (what) {
        case "CLR":
            combiningAcid = []
        case "A":
            combiningAcid.append(Base.A)
        case "G":
            combiningAcid.append(Base.G)
        case "U":
            combiningAcid.append(Base.U)
        case "C":
            combiningAcid.append(Base.C)
        default:
            print("Hello")

        }
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
