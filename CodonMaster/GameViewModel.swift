//
//  GameViewModel.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/27.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    var lock = NSLock()
    @Published var acids: [Acid] = []
    @Published var combiningAcid: AcidCombinator = AcidCombinator()
    @Published var life: Int
    @Published var score: Int
    @Published var isGameOver: Bool
    
    let acidPublisher: AnyPublisher<Acid, Never>
    var acidPublishCancellable: AnyCancellable? = nil
    var gameLoopCancellable: AnyCancellable? = nil
    
    let namemode: NameMode
    let showHint: Bool
    let nickname: String
    
    init() {
        self.life = 100
        self.score = 0
        self.isGameOver = false
        let userDefaults = UserDefaults.standard
        self.namemode = NameMode.allCases[userDefaults.integer(forKey: "namemode")]
        self.showHint = userDefaults.bool(forKey: "show_hint")
        self.nickname = userDefaults.string(forKey: "nickname") ?? "anonymous"
        
        acidPublisher = CodonMaster.acidPublisher()
        acidPublishCancellable = acidPublisher
            .receive(on: RunLoop.main)
            .sink { acid in
                self.lock.with {
                    self.acids.append(acid)
                }
                print("Generated acid \(acid.kind)")
            }
        gameLoopCancellable = Timer.publish(every: 0.025, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { time in
                self.lock.with {
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
                if self.life <= 0 {
                    self.endGame()
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
                self.life = min(self.life + 15, 100)
                self.score += 100
                self.acids.removeFirst()
            } else {
                self.life = max(self.life - 10, 0)
            }
        }
    }
    
    func endGame() {
        invalidate()
        isGameOver = true
    }
}

struct Acid: Hashable {
    var age: Float // 0..1
    let x: Float
    let kind: AcidKind
}
