//
//  SettingView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/21.
//

import Foundation
import SwiftUI


struct SettingView: View {
    @State private var nickname = ""
    @State private var category = "Full name"
    @State private var showHint = false

    let categories = ["Single letter", "3 letters", "Full name", "Korean"]
    var body: some View {
        Form {
            Section(header: Text("계정 정보"), footer: Text("랭킹 등록에 사용할 닉네임을 설정합니다.")) {
                TextField("Nickname", text: $nickname)
            }
            Section(header: Text("게임 설정"), footer: Text("아미노산이 표시될 이름, 힌트 등이 표시됩니다.")) {
                Picker(selection: $category, label: Text("아미노산 이름 모드")) {
                    ForEach(0..<categories.count) { index in
                        Text(categories[index]).tag(index)
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
            }.navigationTitle("Setting")
        }
    }
}
