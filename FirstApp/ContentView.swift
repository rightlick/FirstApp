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
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWeidth = undealtHeight * cardAspectRatio
    }
    
    @ObservedObject var game: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    
    @State private var dealt = Set<Int>()
    
    private func deal (_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (Constans.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: Constans.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var body : some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameHeader
                gameBody
                HStack {
                    newGame
                    Spacer()
                    
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(EmojiMemoryGame.currentTheme.color.last)
            }
            deckBody
        }
        .padding(.all)
        .background(Color.mainColor)
    }
    
    var gameHeader: some View {
        VStack {
            Text(EmojiMemoryGame.currentTheme.name)
                .font(.largeTitle)
                .fontWeight(.black)
            
            Text("Score: \(game.score)")
                .font(.title2)
        }.foregroundColor(EmojiMemoryGame.currentTheme.color.first)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: Constans.cardAspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: Constans.undealtWeidth, height: Constans.undealtHeight)
        .onTapGesture {
            // "deal" cards
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var newGame: some View {
        VStack {
            Button(action: {
                withAnimation {
                    dealt = []
                    game.startNewGame()
                }
            }, label: {
                VStack {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                        .font(.largeTitle)

                    Text("New Game")
                }
            })
        }
    }
    
    var shuffle: some View {
        Button(action: {
            withAnimation {
                game.shuffle()
            }
        }, label: {
            VStack {
                Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    .font(.largeTitle)
                
                Text("Shuffle")
            }
        })
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
        
        static let fontSize: CGFloat = 32
    }
    
    let card : MemoryGame<String>.Card
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (Constans.fontSize / Constans.fontScale)
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body : some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaning
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else if (card.bonusRemaning > 0) {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaning) * 360 - 90))
                    }
                }
                .padding(Constans.paddingOfPie)
                .opacity(Constans.opaciryOfPie)
                .foregroundColor(.green)
                
                Text(card.content)
                
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                
                    .font(Font.system(size: Constans.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, colors: EmojiMemoryGame.currentTheme.color) 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(game: game)
    }
}
