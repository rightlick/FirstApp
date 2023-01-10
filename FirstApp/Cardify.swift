//
//  Cardify.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 09.01.2023.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    private enum Constans {
        static let cornerRadius: CGFloat = 10
        static let strokeBorder: CGFloat = 3
        static let opacity: CGFloat = 0
        static let fontScale: CGFloat = 0.6
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private var colors: [Color]
    
    private var rotation: Double // in degrees
    
    init(isFaceUp: Bool, colors: [Color]) {
        rotation = isFaceUp ? 0 : 180
        self.colors = colors
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constans.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.mainColor)
                shape.stroke(Gradient(colors: colors),
                             lineWidth: Constans.strokeBorder)
            } else {
                shape.fill(Gradient(colors: colors))
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    func cardify(isFaceUp: Bool, colors: [Color]) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, colors: colors))
    }
}
