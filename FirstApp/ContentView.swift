//
//  ContentView.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 03.12.2022.
//

import SwiftUI

struct ContentView : View {
    enum Constans {
        static let minimumCardWidth: CGFloat = 90
        static let cardSpacing: CGFloat = 10
        static let cardAspectRatio: CGFloat = 2/3
    }
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body : some View {
        VStack {
            VStack {
                Text(EmojiMemoryGame.currentTheme.name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Text("Score: \(game.score)")
                    .font(.title2)
            }.foregroundColor(EmojiMemoryGame.currentTheme.color.first)
            
            AspectVGrid(items: game.cards, aspectRatio: Constans.cardAspectRatio) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            
            VStack {
                Button(action: {
                    game.startNewGame()
                }, label: {
                    VStack {
                        Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                        
                        Text("New Game")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }).font(.largeTitle)
            }
            .foregroundColor(EmojiMemoryGame.currentTheme.color.last)
        }
        .padding(.all)
        .background(Color.mainColor)
    }
}



struct CardView : View {
    enum Constans {
        static let cornerRadius: CGFloat = 10
        static let strokeBorder: CGFloat = 3
        static let opacity: CGFloat = 0
        static let fontScale: CGFloat = 0.6
        
        static let opaciryOfPie: CGFloat = 0.4
        static let paddingOfPie: CGFloat = 4
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * Constans.fontScale)
    }
    
    let card : MemoryGame<String>.Card
    
    
    var body : some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: Constans.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.mainColor)
                    shape.stroke(Gradient(colors: EmojiMemoryGame.currentTheme.color), lineWidth: Constans.strokeBorder)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(Constans.paddingOfPie)
                        .opacity(Constans.opaciryOfPie)
                        .foregroundColor(.green /*EmojiMemoryGame.currentTheme.color.last*/)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(Constans.opacity)
                } else {
                    shape.fill(Gradient(colors: EmojiMemoryGame.currentTheme.color))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(game: game)
    }
}
