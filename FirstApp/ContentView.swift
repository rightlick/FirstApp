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
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body : some View {
        VStack {
            VStack {
                Text(EmojiMemoryGame.currentTheme.name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Text("Score: \(viewModel.score)")
                    .font(.title2)
            }.foregroundColor(EmojiMemoryGame.currentTheme.color.first)
                
            let items = [GridItem(.adaptive(minimum: Constans.minimumCardWidth))]
            
            ScrollView {
                LazyVGrid(columns: items, spacing: Constans.cardSpacing) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(Constans.cardAspectRatio, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            
            VStack {
                Button(action: {
                    viewModel.startNewGame()
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
        static let cornerRadius: CGFloat = 15
        static let strokeBorder: CGFloat = 5
        static let opacity: CGFloat = 0
    }
    let card : MemoryGame<String>.Card
    
    var body : some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constans.cornerRadius)
            if card.isFaceUp {
                shape.fill().foregroundColor(.mainColor)
                shape.strokeBorder(lineWidth: Constans.strokeBorder)
                
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(Constans.opacity)
            } else {
                shape.fill(Gradient(colors: EmojiMemoryGame.currentTheme.color))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
