//
//  String+hash.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/29.
//

import Foundation

extension String {
    var ThirtyTwoBitHash: UInt {
        return self.utf8.reduce(0) { $0 * 1093 + 257 * UInt($1) }
    }
}
