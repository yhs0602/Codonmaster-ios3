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
    @Published var combiningAcid: AcidCombinator = AcidCombinator()
    @Published var life: Int
    @Published var score: Int

    let acidPublisher: AnyPublisher<Acid, Never>
    var acidPublishCancellable: AnyCancellable? = nil
    var gameLoopCancellable: AnyCancellable? = nil
    init() {
        self.life = 100
        self.score = 0
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
            if self.acids.contains(where: { acid in
                acid.age > 1
            }) == true {
                self.life -= 10
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
        var result: AcidKind? = nil
        switch (what) {
        case "CLR":
            combiningAcid.reset()
            return
        case "A":
            result = combiningAcid.addBase(base: Base.A)
        case "G":
            result = combiningAcid.addBase(base: Base.G)
        case "U":
            result = combiningAcid.addBase(base: Base.U)
        case "C":
            result = combiningAcid.addBase(base: Base.C)
        default:
            assert(false)
        }
        if let result2 = result {
            combiningAcid.reset()
            if self.acids.first?.kind == result2 {
                self.life += 10
                self.score += 100
            } else {
                self.life -= 20
            }
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


class AcidCombinator: ObservableObject, CustomStringConvertible {
    var description: String {
        return bases.map { base in
            base.rawValue
        }.joined()
    }

    var phase: Int = 0
    var bases: [Base] = []

    func reset() {
        self.bases = []
        self.phase = 0
    }

    func addBase(base: Base) -> AcidKind? {
        switch (self.phase) {
        case 0:
            bases.append(base)
            self.phase += 1
        case 1:
            bases.append(base)
            self.phase += 1
        case 2:
            bases.append(base)
            self.phase += 1
            let acid = getAcid()
            self.phase = 0
            reset()
            return acid
        default:
            assert(false)
        }
        return nil
    }

    private func getAcid() -> AcidKind {
        assert(self.phase == 3)
        switch (bases[0]) {
        case .U:
            switch (bases[1]) {
            case .U: switch (bases[2]) {
                    case .U, .C: return AcidKind.Phe
                    default: return AcidKind.Leu
                }
            case .C: return AcidKind.Ser
            case .A: switch (bases[2]) {
                    case .U, .C: return AcidKind.Tyr
                    default: return AcidKind.End
                }
            case .G: switch (bases[2]) {
                    case .U, .C: return AcidKind.Cys
                    case .A: return AcidKind.End
                    case .G: return AcidKind.Trp
                }
            }
        case .C:
            switch (bases[1]) {
            case .U: return AcidKind.Leu
            case .C: return AcidKind.Pro
            case .A: switch (bases[2]) {
                    case .U, .C: return AcidKind.His
                    default: return AcidKind.Gln
                }
            case .G: return AcidKind.Arg
            }
        case .A:
            switch (bases[1]) {
            case .U: switch (bases[2]) {
                    case .U, .C, .A: return AcidKind.Ile
                    default: return AcidKind.Met
                }
            case .C: return AcidKind.Thr
            case .A: switch (bases[2]) {
                    case .U, .C: return AcidKind.Asn
                    default: return AcidKind.Lys
                }
            case .G: switch (bases[2]) {
                    case .U, .C: return AcidKind.Ser
                    case .A, .G: return AcidKind.Arg
                }
            }
        case .G:
            switch (bases[1]) {
            case .U: return AcidKind.Val
            case .C: return AcidKind.Ala
            case .A: switch (bases[2]) {
                    case .U, .C: return AcidKind.Asp
                    default: return AcidKind.Glu
                }
            case .G: return AcidKind.Gly
            }
        }
    }
}
