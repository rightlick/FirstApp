//
//  ContentView.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 03.12.2022.
//

import SwiftUI

struct ContentView : View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body : some View {
        VStack {
            Text(EmojiMemoryGame.currentTheme.name).font(.largeTitle).fontWeight(.black)
            Text("Score: \(viewModel.score)")
                .font(.title2)
                
            
            let items = [GridItem(.adaptive(minimum: 90))]
            
            ScrollView {
                LazyVGrid(columns: items, spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
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
        }
        .padding(.all)
        .foregroundColor(EmojiMemoryGame.currentTheme.color)
    }
}

struct CardView : View {
    let card : MemoryGame<String>.Card
    
    var body : some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 5)
                
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
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
