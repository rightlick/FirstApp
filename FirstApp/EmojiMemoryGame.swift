//
//  EmojiMemoryGame.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 08.12.2022.
//

//ViewModel?

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static var allThems: Array<MemoryGame<String>.Theme> = [DefaultThemes.moons, DefaultThemes.hearts, DefaultThemes.animals,
                                                            DefaultThemes.clouds, DefaultThemes.fruits, DefaultThemes.zodiac]
    
    static var currentTheme = allThems.randomElement()!
        
    static func createMemoryGame() -> MemoryGame<String> {
            MemoryGame<String>(numberOfPairsOfCards: currentTheme.numberOfPairs)
            { pairIndex in
                currentTheme.emojiKit[pairIndex]
            }
        }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        EmojiMemoryGame.currentTheme = EmojiMemoryGame.allThems.randomElement()!
        model = EmojiMemoryGame.createMemoryGame()
    }
}
