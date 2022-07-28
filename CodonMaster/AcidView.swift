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

