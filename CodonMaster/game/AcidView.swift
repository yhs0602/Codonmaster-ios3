//
//  AcidView.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/28.
//

import Foundation
import SwiftUI

struct AcidView: View {
    let w: CGFloat
    let h: CGFloat
    let x: CGFloat
    let y: CGFloat
    let acid: Acid
    let namemode: NameMode
    let foregroundColor: Color
    let backgroundColor: Color
    
    init(geometry: CGSize, acid: Acid, namemode: NameMode) {
        self.w = geometry.width
        self.h = geometry.height
        self.acid = acid
        self.x = CGFloat(acid.x) * self.w
        self.y = CGFloat(acid.age) * self.h
        self.namemode = namemode
        self.backgroundColor = Color(acid.kind.color)
        if acid.kind.color.isLight(threshold: 0.5) != true {
            self.foregroundColor = Color.white
        } else {
            self.foregroundColor = Color.black
        }
    }
    
    var body: some View {
        Text(acid.kind.description(namemode: namemode))
            .padding(10)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(self.backgroundColor)
                    .shadow(radius: 3)
            )
            .foregroundColor(self.foregroundColor)
            .position(x: x, y: y)
    }
}

