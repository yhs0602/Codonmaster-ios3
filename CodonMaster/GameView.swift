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
    @StateObject var gameViewModel = GameViewModel()

    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                ForEach(gameViewModel.acids, id: \.self) { acid in
                    AcidView(geometry: geometry.size, acid: acid)
                }
            }


            VStack {
                HStack(spacing: 10) {
                    ProgressBar(value: $progressValue).frame(maxHeight: 30)
                    Text(String(score))
                }.padding()
                Spacer()
                //                VStack(alignment: .trailing) {
                //                    Text(String(composing.sequence.joined(""))).frame(maxWidth: .infinity, alignment: .trailing)
                //                }.frame(maxWidth: .infinity)
                HStack(spacing: 0) {
                    BaseButton(title: "U", background: .yellow)
                    BaseButton(title: "C", background: .green)
                    BaseButton(title: "A", background: .red)
                    BaseButton(title: "G", background: .black, foreground: .white)
                    BaseButton(title: "CLR", background: .white)
                }.fixedSize(horizontal: false, vertical: true)
            }
        }.background(.brown)
    }
}

struct AcidView: View {
    let w: CGFloat
    let h: CGFloat
    let x: CGFloat
    let y: CGFloat
    let acid: Acid

    init(geometry: CGSize, acid: Acid) {
        self.w = geometry.width
        self.h = geometry.height
        self.acid = acid
        self.x = CGFloat(acid.x) * self.w
        self.y = CGFloat(acid.age) * self.h
    }

    var body: some View {
        HStack(spacing: 0) {
            Spacer().frame(width: self.x)
            Text(String(describing: acid.kind))
                .padding(10)
                .background(.cyan)
                .position(x: 0, y: y)
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
        Button(title, action: { })
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(background)
            .foregroundColor(foreground)
    }
}
