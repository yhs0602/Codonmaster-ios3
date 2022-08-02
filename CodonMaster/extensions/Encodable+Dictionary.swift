//
//  Encodable+Dictionary.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/08/02.
//

import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
