//
//  SettingView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/21.
//

import Foundation
import SwiftUI

enum NameMode: String, CaseIterable {
    case Single = "Single letter"
    case Three = "Three letters"
    case Full = "Full name"
    case Korean = "Korean"
}

struct SettingView: View {
    @AppStorage("nickname") private var nickname = ""
    @AppStorage("namemode") private var namemode = 0
    @AppStorage("show_hint") private var showHint = false

    let categories = NameMode.allCases
    var body: some View {
        Form {
            Section(header: Text("계정 정보"), footer: Text("게임 종료 시 랭킹에 등록할 닉네임을 설정합니다.")) {
                TextField("Nickname", text: $nickname)
            }
            Section(header: Text("게임 설정"), footer: Text("아미노산이 표시될 이름, 힌트 등이 표시됩니다.")) {
                Picker(selection: $namemode, label: Text("아미노산 이름 모드")) {
                    ForEach(0..<categories.count) { index in
                        Text(String(describing: categories[index])).tag(index)
                    }
                }
                Toggle(isOn: $showHint, label: {
                    Text("힌트 보기")
                })
                NavigationLink {
                    VStack(alignment: .leading) {
                        Text("위에서 떨어지는 아미노산들에 해당하는 트리플렛 코드를 입력하세요. 점수를 얻을 수 있습니다.").padding()
                        Text("잘못 입력하거나 아미노산이 바닥에 닿기 전까지 입력하지 못할 경우 라이프가 감소합니다. 라이프가 0이 되면 게임이 종료됩니다.").padding()
                    }.navigationTitle("도움말")
                } label: {
                    Text("도움말")
                }
            }
        }.navigationTitle("Setting")
    }
}
