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
            Section(header: Text("계정 정보"), footer: Text("랭킹 등록에 사용할 닉네임을 설정합니다.")) {
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
                    Text("도움말")
                } label: {
                    Text("도움말")
                }
            }
        }.navigationTitle("Setting")
    }
}
