//
//  AcidCombinator.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/28.
//

import Foundation

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
