//
//  NSLock+with.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/28.
//

import Foundation

extension NSLock {

    @discardableResult
    func with<T>(_ block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
}
