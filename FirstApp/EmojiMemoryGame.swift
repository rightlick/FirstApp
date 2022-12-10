//
//  EmojiMemoryGame.swift
//  FirstApp
//
//  Created by Liza Likhomanova on 08.12.2022.
//

//ViewModel?

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static var allThems: Array<MemoryGame<String>.Theme> = [DefaultThemes.moons,
                                                            DefaultThemes.hearts,
                                                            DefaultThemes.animals,
                                                            DefaultThemes.clouds,
                                                            DefaultThemes.fruits,
                                                            DefaultThemes.zodiac]
    
    static var currentTheme = allThems.randomElement()!
    
    static func makeArrayUnique(_ array: Array<String>) -> Array<String> {
        var localArray = Array<String>()
        for element in array {
            if !localArray.contains(element) {
                localArray.append(element)
            }
        }
        return localArray
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        currentTheme.emojiKit = makeArrayUnique(currentTheme.emojiKit)
        if currentTheme.numberOfPairs > currentTheme.emojiKit.count {
            currentTheme.numberOfPairs = currentTheme.emojiKit.count
        }
        return MemoryGame<String>(numberOfPairsOfCards: currentTheme.numberOfPairs)
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
