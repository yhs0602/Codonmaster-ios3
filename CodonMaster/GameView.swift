//
//  GameView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/21.
//

import Foundation
import SwiftUI

enum Base {
    case U
    case C
    case A
    case G
}

struct GameView: View {
    @State var progressValue: Float = 0.2
    @State var score: Int = 0
    @State var composing = [Base]()

    var body: some View {
        ZStack {
            Text("UAA").background(.cyan)
            VStack {
                HStack(spacing: 10) {
                    ProgressBar(value: $progressValue).frame(maxHeight: 30)
                    Text(String(score))
                }.padding()
                Spacer()
//                VStack(alignment: .trailing) {
//                    Text(String(composing.sequence.joined(""))).frame(maxWidth: .infinity, alignment: .trailing)
//                }.frame(maxWidth: .infinity)
                HStack {
                    BaseButton(title: "U", background: .yellow)
                    BaseButton(title: "C", background: .green)
                    BaseButton(title: "A", background: .red)
                    BaseButton(title: "G", background: .black, foreground: .white)
                    BaseButton(title: "CLEAR", background: .white)
                }
            }
        }
    }
}

struct BaseButton: View {
    let title: String
    let background: Color
    let foreground: Color
    init(title: String, background: Color, foreground: Color = .black) {
        self.title = title
        self.background = background
        self.foreground = foreground
    }
    var body: some View {
        Button(title, action: { }).frame(maxWidth: .infinity, idealHeight: 200).background(background).foregroundColor(foreground)
    }
}
