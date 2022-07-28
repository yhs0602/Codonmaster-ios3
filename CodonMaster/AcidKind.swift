//
//  AcidKind.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/28.
//

import Foundation

enum AcidKind: CaseIterable {
    case Phe, Leu, Ile, Met, Val, Ser, Pro, Thr, Ala, Tyr, End, His, Gln, Asn, Lys, Asp, Glu, Cys, Trp, Arg, Gly

    var full: String {
        switch (self) {
        case .Phe: return "Phenylalanine"
        case .Leu: return "Leucine"
        case .Ile: return "Isoeucine"
        case .Met: return "Methionine"
        case .Val: return "Valine"
        case .Ser: return "Serine"
        case .Pro: return "Proline"
        case .Thr: return "Threonine"
        case .Ala: return "Alanin"
        case .Tyr: return "Thyrosin"
        case .End: return "Stop"
        case .His: return "Histidine"
        case .Gln: return "Glutamin"
        case .Asn: return "Asparagine"
        case .Lys: return "Lysine"
        case .Asp: return "Aspartic acid"
        case .Glu: return "Glutamic acid"
        case .Cys: return "Cysteine"
        case .Trp: return "Tryptophan"
        case .Arg: return "Arginine"
        case .Gly: return "Glycine"
        }
    }

    var kor: String {
        switch (self) {
        case .Phe: return "페닐알라닌"
        case .Leu: return "류신"
        case .Ile: return "아이소류신"
        case .Met: return "메싸이오닌"
        case .Val: return "발린"
        case .Ser: return "세린"
        case .Pro: return "프롤린"
        case .Thr: return "트레오닌"
        case .Ala: return "알라닌"
        case .Tyr: return "타이로신"
        case .End: return "종결"
        case .His: return "히스티딘"
        case .Gln: return "글루타민"
        case .Asn: return "아스파라진"
        case .Lys: return "라이신"
        case .Asp: return "아스파트산"
        case .Glu: return "글루탐산"
        case .Cys: return "시스테인"
        case .Trp: return "트립토판"
        case .Arg: return "아르지닌"
        case .Gly: return "글라이신"
        }
    }

    var singleLetterName: String {
        switch (self) {
        case .Phe: return "F"
        case .Leu: return "L"
        case .Ile: return "I"
        case .Met: return "M"
        case .Val: return "V"
        case .Ser: return "S"
        case .Pro: return "P"
        case .Thr: return "T"
        case .Ala: return "A"
        case .Tyr: return "Y"
        case .End: return "-"
        case .His: return "H"
        case .Gln: return "Q"
        case .Asn: return "N"
        case .Lys: return "K"
        case .Asp: return "D"
        case .Glu: return "E"
        case .Cys: return "C"
        case .Trp: return "W"
        case .Arg: return "R"
        case .Gly: return "G"
        }
    }

    var codon: String {
        switch (self) {
        case .Phe: return "UUU, UUC"
        case .Leu: return "UUA, UUG, CUU, CUC, CUA, CUG"
        case .Ile: return "AUU, AUC AUA"
        case .Met: return "AUG"
        case .Val: return "GUU, GUC, GUA, GUG"
        case .Ser: return "UCU, UCC, UCA, UCG, AGU, AGC"
        case .Pro: return "CCU, CCC, CCA, CCG"
        case .Thr: return "ACU, ACC, ACA, ACG"
        case .Ala: return "GCU, GCC, GCA, GCG"
        case .Tyr: return "UAU, UAC"
        case .End: return "UAA, UGA, UAG"
        case .His: return "CAU, CAC"
        case .Gln: return "CAA, CAG"
        case .Asn: return "AAU, AAC"
        case .Lys: return "AAA, AAG"
        case .Asp: return "GAU, GAC"
        case .Glu: return "GAA, GAG"
        case .Cys: return "UGU, UGC"
        case .Trp: return "UGG"
        case .Arg: return "CGU, CGC, CGA, CGG, AGA, AGG"
        case .Gly: return "GGU, GGC, GGA, GGG"
        }
    }
}
