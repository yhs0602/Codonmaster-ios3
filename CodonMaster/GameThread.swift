//
//  GameThread.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/27.
//

import Foundation
import Combine

func acidPublisher() -> AnyPublisher<Acid, Never> {
    return Timer
        .publish(every: 4, on: .main, in: .default)
        .autoconnect()
        .receive(on: DispatchQueue.global())
        .map { date in
            Acid(age: 0, x: Float.random(in: 0.1..<0.9), kind: AcidKind.allCases.randomElement()!)
    }
        .eraseToAnyPublisher()
}
