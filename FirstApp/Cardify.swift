//
//  Cardify.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 09.01.2023.
//

import SwiftUI

struct Cardify: ViewModifier {
    enum Constans {
        static let cornerRadius: CGFloat = 10
        static let strokeBorder: CGFloat = 3
        static let opacity: CGFloat = 0
        static let fontScale: CGFloat = 0.6
    }
    
    var isFaceUp: Bool
    var colors: [Color]
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constans.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.mainColor)
                shape.stroke(Gradient(colors: colors),
                             lineWidth: Constans.strokeBorder)
            } else {
                shape.fill(Gradient(colors: colors))
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool, colors: [Color]) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, colors: colors))
    }
}
