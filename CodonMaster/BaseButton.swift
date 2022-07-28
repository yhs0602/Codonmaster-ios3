//
//  BaseButton.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/28.
//

import Foundation
import SwiftUI

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
