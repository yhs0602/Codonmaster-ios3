//
//  GameView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/21.
//

import Foundation
import SwiftUI


struct GameView: View {
    @StateObject var gameViewModel = GameViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .topLeading) {
                    GeometryReader { geometry in
                        ForEach(gameViewModel.acids, id: \.self) { acid in
                            AcidView(geometry: geometry.size, acid: acid, namemode: gameViewModel.namemode)
                        }
                    }
                    HStack(spacing: 10) {
                        ProgressBar(value: Binding.constant(Float(gameViewModel.life) / 100.0)).frame(maxHeight: 30)
                        Text(String(gameViewModel.score))
                    }.padding()
                    Spacer()
                }
                Text(gameViewModel.combiningAcid.description)
                HStack(spacing: 0) {
                    BaseButton(title: "U", onClick: gameViewModel.onClickBase, background: .yellow)
                    BaseButton(title: "C", onClick: gameViewModel.onClickBase, background: .green)
                    BaseButton(title: "A", onClick: gameViewModel.onClickBase, background: .red)
                    BaseButton(title: "G", onClick: gameViewModel.onClickBase, background: .black, foreground: .white)
                    BaseButton(title: "CLR", onClick: gameViewModel.onClickBase, background: .white)
                }.fixedSize(horizontal: false, vertical: true)
            }
            if gameViewModel.showHint {
                Text("Hint: \(gameViewModel.acids.first?.kind.codon ?? "unknown")")
            }

            if gameViewModel.isGameOver {
                VStack {
                    Text("GameOver! \(gameViewModel.nickname)")
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }, label: {
                        Text("Go back")
                    })
                }.background(.brown).padding()
            }
        }
            .onDisappear {
            self.gameViewModel.invalidate()
        }
    }
}
