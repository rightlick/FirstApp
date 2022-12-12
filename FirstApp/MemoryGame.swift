//
//  MemoryGame.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 08.12.2022.
//

// Model?

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                                //если контент на двух карточках совпал
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    EmojiMemoryGame.currentTheme.score += 2
                } else {        //если контент на двух карточках не совпал
                
                    //если первая открытая карточка уже переворачивалась до этого, то -1 балл
                    if cards[chosenIndex].wasShown {
                        EmojiMemoryGame.currentTheme.score -= 1
                    }
                    //если вторая открытая карточка уже переворачивалась до этого, то -1 балл
                    if cards[potentialMatchIndex].wasShown {
                        EmojiMemoryGame.currentTheme.score -= 1
                    }
                }
                cards[chosenIndex].wasShown = true             //этак карточка переворачивалась
                cards[potentialMatchIndex].wasShown = true     //этак карточка переворачивалась
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var wasShown: Bool = false
    }
    
    struct Theme {
        var name: String
        var emojiKit: Array<String>
        var numberOfPairs: Int
        var color: Color
        var score: Int //
    }
}
