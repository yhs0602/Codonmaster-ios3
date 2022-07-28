//
//  GameView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/21.
//

import Foundation
import SwiftUI

enum Base: String, CaseIterable {
    case U
    case C
    case A
    case G
}

struct GameView: View {
    @State var progressValue: Float = 0.2
    @State var score: Int = 0
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
                Text(gameViewModel.combiningAcid.map { base in
                    base.rawValue
                }.joined(separator: "")
                )
                HStack(spacing: 0) {
                    BaseButton(title: "U", onClick: gameViewModel.onClickBase, background: .yellow)
                    BaseButton(title: "C", onClick: gameViewModel.onClickBase, background: .green)
                    BaseButton(title: "A", onClick: gameViewModel.onClickBase, background: .red)
                    BaseButton(title: "G", onClick: gameViewModel.onClickBase, background: .black, foreground: .white)
                    BaseButton(title: "CLR", onClick: gameViewModel.onClickBase, background: .white)
                }.fixedSize(horizontal: false, vertical: true)
            }
        }.onDisappear {
            self.gameViewModel.invalidate()
        }
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
        Text(String(describing: acid.kind))
            .padding(10)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(radius: 3)
            )
            .position(x: x, y: y)
    }
}

struct BaseButton: View {
    let title: String
    let background: Color
    let foreground: Color
    let onClick: (String) -> ()
    init(title: String, onClick: @escaping (String) -> (), background: Color, foreground: Color = .black) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.onClick = onClick
    }
    var body: some View {
        Button(action: { onClick(title) }, label: {
            Text(title)
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(background)
                .foregroundColor(foreground)
        })
    }
}
